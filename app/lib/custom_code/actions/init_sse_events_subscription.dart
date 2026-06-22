// Automatic FlutterFlow imports
import 'dart:async';

import '/backend/events/sse_events_client.dart';
// Imports other custom actions
import 'sse_event_handlers.dart';
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Replaces the previous Supabase Realtime path
// (`init_supabase_realtime_subscriptions.dart`). Same downstream effect
// on `FFAppState()`, but driven by SSE from the accounts service
// (`/events/stream`) instead of `postgres_changes` channels on
// `public:contracts` / `public:customers`. See
// specs/sse-events.md for the wire protocol.
final _events = SseEventsClient();
StreamSubscription<Map<String, dynamic>>? _contractSignedSubscription;
StreamSubscription<Map<String, dynamic>>? _customerUpdatedSubscription;

Future initSseEventsSubscription() async {
  await _contractSignedSubscription?.cancel();
  await _customerUpdatedSubscription?.cancel();

  await _events.connect();

  _contractSignedSubscription =
      _events.contractSigned.listen(handleContractSignedEvent);
  _customerUpdatedSubscription =
      _events.customerUpdated.listen(handleCustomerUpdatedEvent);
}

Future disconnectSseEventsSubscription() async {
  await _contractSignedSubscription?.cancel();
  await _customerUpdatedSubscription?.cancel();
  _contractSignedSubscription = null;
  _customerUpdatedSubscription = null;
  await _events.disconnect();
}
