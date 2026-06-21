// Automatic FlutterFlow imports
import '/backend/events/contract_events_client.dart';
// Imports other custom actions
import 'contract_event_handlers.dart';
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Replaces the previous Supabase Realtime path
// (`init_supabase_realtime_subscriptions.dart`). Same downstream effect
// on `FFAppState()`, but driven by SSE from the accounts service
// (`/contracts/events`) instead of `postgres_changes` channels on
// `public:contracts` / `public:customers`. See
// specs/contract-events-sse.md for the wire protocol.
Future initContractEventsSubscription() async {
  final events = ContractEventsClient();
  await events.connect();

  events.contractSigned.listen(handleContractSignedEvent);
  events.customerUpdated.listen(handleCustomerUpdatedEvent);
}