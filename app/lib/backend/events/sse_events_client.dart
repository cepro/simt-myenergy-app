// SSE subscriber that talks to the /events/stream endpoint on the
// accounts service. Exposes two broadcast streams — `contractSigned`
// and `customerUpdated` — so callers can subscribe independently.
//
// The LD `SSEClient` filters by event type on the wire (see the
// `eventTypes` set passed to its constructor), so the server-driven
// `ping` heartbeat never reaches our handlers; we only ever see
// `contract_signed` and `customer_updated` MessageEvents.

import 'dart:async';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:launchdarkly_event_source_client/launchdarkly_event_source_client.dart';

import '/auth/supabase_auth/auth_util.dart';
import '/config/environment.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SseEventsClient {
  SSEClient? _client;
  final _contractSigned = StreamController<Map<String, dynamic>>.broadcast();
  final _customerUpdated = StreamController<Map<String, dynamic>>.broadcast();

  Stream<Map<String, dynamic>> get contractSigned => _contractSigned.stream;
  Stream<Map<String, dynamic>> get customerUpdated => _customerUpdated.stream;

  Future<void> connect() async {
    await disconnect();

    // Honor an active impersonation session if one is set, otherwise
    // fall back to the Supabase JWT cached on the auth_util.
    final impersonation = FFAppState().impersonationToken;
    final jwt = impersonation.isNotEmpty ? impersonation : currentJwtToken;
    if (jwt.isEmpty) {
      print('contract events: no JWT, skipping connect');
      return;
    }

    // The browser's native `EventSource` cannot set custom request
    // headers, so on web we put the JWT in the query string and let the
    // backend's `/events/stream` filter chain accept it.
    final supportsHeaders = !kIsWeb;
    final endpoint = Uri.parse(
        '${Environment.config.myenergyServiceURI}/events/stream');
    final url = supportsHeaders
        ? endpoint
        : endpoint.replace(queryParameters: {'access_token': jwt});
    // Log the endpoint only — never the `url` with the access_token
    // query param. On web the JWT in the URL must not land in DevTools
    // or log forwarders.
    final transport = supportsHeaders ? 'Authorization header' : 'access_token query';
    print('contract events: starting connect (transport=$transport, endpoint=$endpoint, hasQueryAuth=${!supportsHeaders})');

    _client = SSEClient(
      url,
      {'contract_signed', 'customer_updated'},
      headers: supportsHeaders
          ? {'Authorization': 'Bearer $jwt'}
          : const <String, String>{},
      connectTimeout: const Duration(seconds: 10),
      readTimeout: const Duration(minutes: 5),
    );

    _client!.stream.listen(
      (event) {
        if (event is OpenEvent) {
          // Server accepted the connection — pairs with the
          // `SSE stream opened` log on the accounts service side.
          print('contract events: opened');
          return;
        }
        if (event is! MessageEvent) return;
        try {
          final payload = jsonDecode(event.data) as Map<String, dynamic>;
          switch (event.type) {
            case 'contract_signed':
              _contractSigned.add(payload);
              break;
            case 'customer_updated':
              _customerUpdated.add(payload);
              break;
            // 'ping' never reaches here — the LD client filters by event
            // type on the wire using the set passed to its constructor.
          }
        } catch (e) {
          print('contract events: failed to parse $event: $e');
        }
      },
      onError: (Object err) {
        if (err is UnrecoverableStatusError &&
            (err.statusCode == 401 || err.statusCode == 403)) {
          // JWT rejected — the LD client will not retry. Bubble up to
          // force re-auth. Out of scope for PR 2.
          print(
              'contract events: auth rejected (${err.statusCode}); will not retry');
        }
        // Transient errors (network drops, 5xx) are swallowed — the LD
        // client will backoff and retry automatically.
      },
      onDone: () {
        // Stream closed cleanly (server shutdown, explicit close, or
        // network drop after the response was fully read). The LD
        // client will not auto-reconnect from here on web — useful to
        // spot silent disconnects vs. expected disconnects from
        // `disconnect()`.
        print('contract events: stream closed');
      },
    );
  }

  Future<void> disconnect() async {
    await _client?.close();
    _client = null;
  }
}