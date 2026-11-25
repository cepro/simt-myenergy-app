// Friendly error mapping for `GET /contract/{id}/signing-embed.html`.
//
// The accounts service returns specific statuses for the multi-party
// signing flow (see `UIHTMLController.renderMultiPartyEmbed`):
//   403 - caller is not a registered proprietor of the property
//   409 - multi-party terms but fewer than 2 registered proprietors
//   502 - the DocuSeal API call failed
// Anything else (including no response at all) gets a generic retryable
// message. The response body is never shown: it is a Spring error body,
// not user-facing text.

class ContractSignEmbedError {
  const ContractSignEmbedError({
    required this.statusCode,
    required this.title,
    required this.message,
    required this.retryable,
  });

  final int? statusCode;
  final String title;
  final String message;
  final bool retryable;
}

ContractSignEmbedError contractSignEmbedErrorFor(int? statusCode) {
  switch (statusCode) {
    case 403:
      return ContractSignEmbedError(
        statusCode: statusCode,
        title: 'You can\'t sign this contract',
        message: 'Only the registered proprietors of this property can sign '
            'this contract. If you think you should be one of them, please '
            'contact support.',
        retryable: false,
      );
    case 409:
      return ContractSignEmbedError(
        statusCode: statusCode,
        title: 'Second proprietor missing',
        message: 'This contract must be signed by both registered '
            'proprietors, but we only have one on record for this property. '
            'Please contact support so we can add the other proprietor.',
        retryable: false,
      );
    case 502:
      return ContractSignEmbedError(
        statusCode: statusCode,
        title: 'Signing service unavailable',
        message: 'We couldn\'t reach our document signing service. Please '
            'try again in a moment.',
        retryable: true,
      );
    default:
      return ContractSignEmbedError(
        statusCode: statusCode,
        title: 'Couldn\'t open the contract',
        message: 'Something went wrong opening the contract. Please try '
            'again. If it keeps happening, please contact support.',
        retryable: true,
      );
  }
}
