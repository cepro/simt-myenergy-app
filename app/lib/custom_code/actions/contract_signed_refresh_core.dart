// VM-testable core of contract_signed_refresh.dart. It must not import the
// app's structs, API calls or app state: those pull in web-only libraries
// and the pre-commit hook runs `flutter test` on the VM.

const List<Duration> kContractSignedRefreshDelays = [
  Duration(seconds: 1),
  Duration(seconds: 2),
  Duration(seconds: 4),
  Duration(seconds: 8),
  Duration(seconds: 15),
  Duration(seconds: 30),
];

/// Waits each delay in [delays] and then calls [attempt], until [attempt]
/// returns a non-null value. Returns that value, or null if every attempt
/// came back null. An attempt that throws counts as "not yet".
Future<T?> pollUntilFound<T>({
  required Future<T?> Function() attempt,
  List<Duration> delays = kContractSignedRefreshDelays,
  void Function(Object error)? onError,
}) async {
  for (final delay in delays) {
    await Future.delayed(delay);
    try {
      final result = await attempt();
      if (result != null) return result;
    } catch (e) {
      onError?.call(e);
    }
  }
  return null;
}
