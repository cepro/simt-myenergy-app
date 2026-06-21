// Automatic FlutterFlow imports
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
Future initSseEventsSubscription() async {
  final events = SseEventsClient();
  await events.connect();

  events.contractSigned.listen(handleContractSignedEvent);
  events.customerUpdated.listen(handleCustomerUpdatedEvent);
}