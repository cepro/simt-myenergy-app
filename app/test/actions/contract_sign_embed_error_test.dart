import 'package:flutter_test/flutter_test.dart';
import 'package:my_energy/actions/contract_sign_embed_error.dart';

void main() {
  group('contractSignEmbedErrorFor', () {
    test('403 is a not-a-proprietor message with no retry', () {
      final e = contractSignEmbedErrorFor(403);
      expect(e.statusCode, 403);
      expect(e.retryable, isFalse);
      expect(e.message, contains('registered proprietors'));
    });

    test('409 asks the customer to contact support, no retry', () {
      final e = contractSignEmbedErrorFor(409);
      expect(e.retryable, isFalse);
      expect(e.message, contains('contact support'));
    });

    test('502 is retryable', () {
      final e = contractSignEmbedErrorFor(502);
      expect(e.retryable, isTrue);
      expect(e.title, 'Signing service unavailable');
    });

    test('other statuses and no response fall back to a retryable message', () {
      for (final status in [500, 404, 0, null]) {
        final e = contractSignEmbedErrorFor(status);
        expect(e.retryable, isTrue, reason: 'status $status');
        expect(e.title, 'Couldn\'t open the contract');
      }
    });
  });
}
