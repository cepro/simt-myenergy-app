// Signing progress line for multi-party contracts, shown in the solar
// contract modal. Uses plain Material (no FlutterFlowTheme, which pulls in
// app state) so it can be widget tested on the VM; the modal passes its
// theme's text style in.

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '/backend/schema/contract_signers.dart';

String formatSignedDate(DateTime? date) =>
    date == null ? '' : DateFormat('d MMMM yyyy').format(date);

String _name(ContractSigner? signer) =>
    (signer == null || signer.fullname.isEmpty)
        ? 'the other proprietor'
        : signer.fullname;

String _signedOn(ContractSigner signer) {
  final date = formatSignedDate(signer.signedDate);
  return date.isEmpty ? 'signed' : 'signed on $date';
}

String _capitalise(String s) =>
    s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);

/// The progress message for a contract that needs [signaturesRequired]
/// signatures, given what `/signers` returned ([signers] is null while
/// loading or if the call failed).
String signingProgressMessage({
  required int signaturesRequired,
  required ContractSigners? signers,
}) {
  const generic = 'This contract must be signed by both registered '
      'proprietors before it takes effect.';

  if (signers == null || signers.signers.isEmpty) return generic;

  if (signers.signed || signers.signers.every((s) => s.signed)) {
    return 'Both proprietors have signed. Your signed contract is being '
        'prepared.';
  }

  final me = signers.currentCustomer;
  final others = signers.others;
  final other = others.isEmpty ? null : others.first;

  if (me == null) {
    // Not one of the signers (for example a Cepro user viewing the
    // contract): list each signer's state.
    return signers.signers
        .map((s) => s.signed
            ? '${_capitalise(_name(s))} ${_signedOn(s)}.'
            : '${_capitalise(_name(s))} has not signed yet.')
        .join(' ');
  }

  if (me.signed) {
    return 'You ${_signedOn(me)}. Waiting for ${_name(other)} to sign.';
  }
  if (other != null && other.signed) {
    return '${_capitalise(_name(other))} ${_signedOn(other)}. '
        'Waiting for you to sign.';
  }
  return 'You and ${_name(other)} both need to sign this contract. '
      'Neither of you has signed yet.';
}

class ContractSigningProgressWidget extends StatelessWidget {
  const ContractSigningProgressWidget({
    super.key,
    required this.signaturesRequired,
    required this.signers,
    this.textStyle,
  });

  final int signaturesRequired;
  final ContractSigners? signers;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      key: const ValueKey('contract-signing-progress'),
      width: double.infinity,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.people_outline, color: theme.colorScheme.primary),
          const SizedBox(width: 12.0),
          Expanded(
            child: Text(
              signingProgressMessage(
                signaturesRequired: signaturesRequired,
                signers: signers,
              ),
              style: textStyle,
            ),
          ),
        ],
      ),
    );
  }
}
