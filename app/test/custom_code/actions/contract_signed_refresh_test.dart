import 'package:flutter_test/flutter_test.dart';
import 'package:my_energy/custom_code/actions/contract_signed_refresh_core.dart';

const _noDelays = [Duration.zero, Duration.zero, Duration.zero];

void main() {
  group('pollUntilFound', () {
    test('keeps trying until a value comes back', () async {
      var calls = 0;
      final result = await pollUntilFound<String>(
        delays: _noDelays,
        attempt: () async => ++calls >= 2 ? 'pdf-url' : null,
      );
      expect(calls, 2);
      expect(result, 'pdf-url');
    });

    test('treats a throwing attempt as "not yet" and reports it', () async {
      var calls = 0;
      final errors = <Object>[];
      final result = await pollUntilFound<String>(
        delays: _noDelays,
        onError: errors.add,
        attempt: () async {
          calls++;
          if (calls == 1) throw Exception('network');
          return 'pdf-url';
        },
      );
      expect(calls, 2);
      expect(errors, hasLength(1));
      expect(result, 'pdf-url');
    });

    test('gives up after the last delay', () async {
      var calls = 0;
      final result = await pollUntilFound<String>(
        delays: _noDelays,
        attempt: () async {
          calls++;
          return null;
        },
      );
      expect(calls, _noDelays.length);
      expect(result, isNull);
    });

    test('default schedule waits about a minute in total', () {
      final total = kContractSignedRefreshDelays.fold<Duration>(
          Duration.zero, (a, b) => a + b);
      expect(total, const Duration(seconds: 60));
    });
  });
}
