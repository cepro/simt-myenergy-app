import 'package:flutter_test/flutter_test.dart';
import 'package:my_energy/backend/schema/contract_signers.dart';

void main() {
  group('ContractSigners.fromJson', () {
    test('parses the /signers response', () {
      final s = ContractSigners.fromJson({
        'signaturesRequired': 2,
        'signed': false,
        'signers': [
          {
            'customerId': 'a',
            'fullname': ' Alice Smith ',
            'role': 'First Party',
            'signed': true,
            'signedDate': '2026-11-25',
            'isCurrentCustomer': true,
          },
          {
            'customerId': 'b',
            'fullname': 'Bob Jones',
            'role': 'Second Party',
            'signed': false,
            'signedDate': null,
            'isCurrentCustomer': false,
          },
        ],
      })!;
      expect(s.signaturesRequired, 2);
      expect(s.signed, isFalse);
      expect(s.signers, hasLength(2));
      expect(s.currentCustomer?.fullname, 'Alice Smith');
      expect(s.currentCustomer?.signedDate, DateTime(2026, 11, 25));
      expect(s.others.single.customerId, 'b');
      expect(s.others.single.signedDate, isNull);
    });

    test('accepts a LocalDate written as an array', () {
      final s = ContractSigners.fromJson({
        'signers': [
          {
            'signed': true,
            'signedDate': [2026, 1, 2]
          }
        ],
      })!;
      expect(s.signers.single.signedDate, DateTime(2026, 1, 2));
    });

    test('defaults missing fields and tolerates an empty signer list', () {
      final s = ContractSigners.fromJson({'signers': []})!;
      expect(s.signaturesRequired, 1);
      expect(s.signed, isFalse);
      expect(s.signers, isEmpty);
      expect(s.currentCustomer, isNull);
    });

    test('returns null for a non-object body', () {
      expect(ContractSigners.fromJson(null), isNull);
      expect(ContractSigners.fromJson('oops'), isNull);
      expect(ContractSigners.fromJson([1, 2]), isNull);
    });
  });
}
