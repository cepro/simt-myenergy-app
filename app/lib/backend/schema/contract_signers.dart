// Response of `GET /contract/{id}/signers` (accounts service PR #88):
//
//   { signaturesRequired, signed,
//     signers: [{ customerId, fullname, role, signed, signedDate,
//                 isCurrentCustomer }] }
//
// Plain Dart (no FlutterFlow struct) so it can be unit tested on the VM.
// `signers` is empty until the first proprietor opens the contract, because
// the DocuSeal submission is created lazily.

class ContractSigner {
  const ContractSigner({
    required this.customerId,
    required this.fullname,
    required this.role,
    required this.signed,
    required this.signedDate,
    required this.isCurrentCustomer,
  });

  final String customerId;
  final String fullname;
  final String role;
  final bool signed;
  final DateTime? signedDate;
  final bool isCurrentCustomer;

  static ContractSigner fromJson(Map<String, dynamic> json) => ContractSigner(
        customerId: json['customerId'] as String? ?? '',
        fullname: (json['fullname'] as String? ?? '').trim(),
        role: json['role'] as String? ?? '',
        signed: json['signed'] == true,
        signedDate: _parseDate(json['signedDate']),
        isCurrentCustomer: json['isCurrentCustomer'] == true,
      );
}

class ContractSigners {
  const ContractSigners({
    required this.signaturesRequired,
    required this.signed,
    required this.signers,
  });

  final int signaturesRequired;
  final bool signed;
  final List<ContractSigner> signers;

  ContractSigner? get currentCustomer {
    for (final s in signers) {
      if (s.isCurrentCustomer) return s;
    }
    return null;
  }

  List<ContractSigner> get others =>
      signers.where((s) => !s.isCurrentCustomer).toList();

  /// Parses the endpoint's JSON body. Returns null if it isn't the expected
  /// shape.
  static ContractSigners? fromJson(dynamic json) {
    if (json is! Map) return null;
    final rawSigners = json['signers'];
    return ContractSigners(
      signaturesRequired: json['signaturesRequired'] is int
          ? json['signaturesRequired'] as int
          : 1,
      signed: json['signed'] == true,
      signers: rawSigners is List
          ? rawSigners
              .whereType<Map>()
              .map((s) => ContractSigner.fromJson(s.cast<String, dynamic>()))
              .toList()
          : const [],
    );
  }
}

// LocalDate from Jackson: "2026-11-25", or [2026, 11, 25] if dates are
// written as arrays.
DateTime? _parseDate(dynamic value) {
  if (value is String && value.isNotEmpty) return DateTime.tryParse(value);
  if (value is List && value.length >= 3 && value.every((v) => v is int)) {
    return DateTime(value[0] as int, value[1] as int, value[2] as int);
  }
  return null;
}
