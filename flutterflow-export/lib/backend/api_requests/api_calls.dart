import 'dart:convert';
import 'dart:typed_data';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class GetCustomersPaymentMethodsCall {
  static Future<ApiCallResponse> call({
    String? bearerToken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Get Customers Payment Methods',
      apiUrl:
          'https://c2xw3up7c7.eu-west-1.awsapprunner.com/customers/paymentMethods',
      callType: ApiCallType.GET,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${bearerToken}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  static List? allRecords(dynamic response) => getJsonField(
        response,
        r'''$[*]''',
        true,
      ) as List?;
}

class GetCustomersAccountsCall {
  static Future<ApiCallResponse> call({
    String? bearerToken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Get Customers Accounts',
      apiUrl: 'https://qecg6jbdmm.eu-west-1.awsapprunner.com/account',
      callType: ApiCallType.GET,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${bearerToken}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  static List? allRecords(dynamic response) => getJsonField(
        response,
        r'''$[*]''',
        true,
      ) as List?;
}

class CreateStripeCheckoutSessionCall {
  static Future<ApiCallResponse> call({
    String? bearerToken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Create Stripe Checkout Session',
      apiUrl:
          'https://c2xw3up7c7.eu-west-1.awsapprunner.com/customers/checkoutSession',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${bearerToken}',
      },
      params: {},
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  static dynamic checkoutPageURI(dynamic response) => getJsonField(
        response,
        r'''$.checkoutPageURI''',
      );
}

class DeleteCustomersPaymentMethodCall {
  static Future<ApiCallResponse> call({
    String? id = '',
    String? bearerToken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Delete Customers Payment Method',
      apiUrl:
          'https://c2xw3up7c7.eu-west-1.awsapprunner.com/customers/paymentMethods/${id}',
      callType: ApiCallType.DELETE,
      headers: {
        'Authorization': 'Bearer ${bearerToken}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class UpdateTopupPreferencesCall {
  static Future<ApiCallResponse> call({
    String? bearerToken = '',
    int? amount,
    int? threshold,
    String? walletId = '',
  }) async {
    final ffApiRequestBody = '''
{
  "amount": ${amount},
  "threshold": ${threshold}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Update Topup Preferences',
      apiUrl:
          'https://qecg6jbdmm.eu-west-1.awsapprunner.com/wallet/${walletId}/topupPreference',
      callType: ApiCallType.PUT,
      headers: {
        'Authorization': 'Bearer ${bearerToken}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class MarkContractSignedCall {
  static Future<ApiCallResponse> call({
    String? bearerToken = '',
    String? contractId = '',
  }) async {
    final ffApiRequestBody = '''
{}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Mark Contract Signed',
      apiUrl:
          'https://qecg6jbdmm.eu-west-1.awsapprunner.com/contract/${contractId}/sign',
      callType: ApiCallType.PUT,
      headers: {
        'Authorization': 'Bearer ${bearerToken}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class GetWalletsCall {
  static Future<ApiCallResponse> call({
    String? bearerToken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Get Wallets',
      apiUrl: 'https://qecg6jbdmm.eu-west-1.awsapprunner.com/wallet',
      callType: ApiCallType.GET,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${bearerToken}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class CustomerInviteLookupCall {
  static Future<ApiCallResponse> call({
    String? inviteToken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Customer Invite Lookup',
      apiUrl:
          'https://qecg6jbdmm.eu-west-1.awsapprunner.com/customer/invite/${inviteToken}',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class ContractSigningEmbedCall {
  static Future<ApiCallResponse> call({
    String? bearerToken = '',
    String? id = '',
    String? termsSubtype = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Contract Signing Embed',
      apiUrl:
          'https://qecg6jbdmm.eu-west-1.awsapprunner.com/contract/${id}/signing-embed.html',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${bearerToken}',
      },
      params: {
        'termsSubtype': termsSubtype,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class ContractTermsLatestCall {
  static Future<ApiCallResponse> call({
    String? bearerToken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Contract Terms latest',
      apiUrl: 'https://qecg6jbdmm.eu-west-1.awsapprunner.com/contractTerms',
      callType: ApiCallType.GET,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${bearerToken}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list);
  } catch (_) {
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar);
  } catch (_) {
    return isList ? '[]' : '{}';
  }
}
