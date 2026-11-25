import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_energy/backend/schema/contract_signers.dart';
import 'package:my_energy/components/contract_signing_progress/contract_signing_progress_widget.dart';

ContractSigner _signer(String name,
        {bool me = false, bool signed = false, DateTime? on}) =>
    ContractSigner(
      customerId: name,
      fullname: name,
      role: me ? 'First Party' : 'Second Party',
      signed: signed,
      signedDate: on,
      isCurrentCustomer: me,
    );

ContractSigners _signers(List<ContractSigner> s, {bool signed = false}) =>
    ContractSigners(signaturesRequired: 2, signed: signed, signers: s);

String _msg(ContractSigners? s) =>
    signingProgressMessage(signaturesRequired: 2, signers: s);

final _nov25 = DateTime(2026, 11, 25);

void main() {
  group('signingProgressMessage', () {
    test('generic message while loading or before the submission exists', () {
      expect(_msg(null), contains('both registered proprietors'));
      expect(_msg(_signers([])), contains('both registered proprietors'));
    });

    test('I signed, co-signer has not', () {
      expect(
        _msg(_signers([
          _signer('Alice', me: true, signed: true, on: _nov25),
          _signer('Bob'),
        ])),
        'You signed on 25 November 2026. Waiting for Bob to sign.',
      );
    });

    test('co-signer signed, I have not', () {
      expect(
        _msg(_signers([
          _signer('Alice', me: true),
          _signer('Bob', signed: true, on: _nov25),
        ])),
        'Bob signed on 25 November 2026. Waiting for you to sign.',
      );
    });

    test('nobody signed yet', () {
      expect(
        _msg(_signers([_signer('Alice', me: true), _signer('Bob')])),
        'You and Bob both need to sign this contract. '
        'Neither of you has signed yet.',
      );
    });

    test('both signed, PDF not ready yet', () {
      final both = [
        _signer('Alice', me: true, signed: true, on: _nov25),
        _signer('Bob', signed: true, on: _nov25),
      ];
      expect(_msg(_signers(both)), contains('being prepared'));
      expect(_msg(_signers(both, signed: true)), contains('being prepared'));
    });

    test('co-signer with no name', () {
      final s = _signers([
        _signer('Alice', me: true, signed: true, on: _nov25),
        const ContractSigner(
            customerId: 'b',
            fullname: '',
            role: 'Second Party',
            signed: false,
            signedDate: null,
            isCurrentCustomer: false),
      ]);
      expect(_msg(s), endsWith('Waiting for the other proprietor to sign.'));
    });

    test('signed without a date', () {
      expect(
        _msg(_signers(
            [_signer('Alice', me: true, signed: true), _signer('Bob')])),
        'You signed. Waiting for Bob to sign.',
      );
    });

    test('viewer is not a signer (e.g. a Cepro user)', () {
      expect(
        _msg(_signers([
          _signer('Alice', signed: true, on: _nov25),
          _signer('Bob'),
        ])),
        'Alice signed on 25 November 2026. Bob has not signed yet.',
      );
    });
  });

  testWidgets('ContractSigningProgressWidget renders the progress message',
      (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ContractSigningProgressWidget(
          signaturesRequired: 2,
          signers: _signers([
            _signer('Alice', me: true),
            _signer('Bob', signed: true, on: _nov25),
          ]),
        ),
      ),
    ));
    expect(find.byKey(const ValueKey('contract-signing-progress')),
        findsOneWidget);
    expect(
        find.text('Bob signed on 25 November 2026. Waiting for you to sign.'),
        findsOneWidget);
    expect(find.byIcon(Icons.people_outline), findsOneWidget);
  });

  testWidgets(
      'ContractSigningProgressWidget shows the generic message '
      'when signers have not loaded', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body:
            ContractSigningProgressWidget(signaturesRequired: 2, signers: null),
      ),
    ));
    expect(find.textContaining('both registered proprietors'), findsOneWidget);
  });
}
