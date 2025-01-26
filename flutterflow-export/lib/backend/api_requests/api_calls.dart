import 'dart:convert';
import 'dart:typed_data';
import '../schema/structs/index.dart';

import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class GetCustomersPaymentMethodsCall {
  static Future<ApiCallResponse> call({
    String? bearerToken = '',
    String? esco = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Get Customers Payment Methods',
      apiUrl:
          'https://simt-j-accounts-qa.fly.dev/stripe/customers/paymentMethods/${esco}',
      callType: ApiCallType.GET,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${bearerToken}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? allRecords(dynamic response) => getJsonField(
        response,
        r'''$[*]''',
        true,
      ) as List?;
}

class GetStripeCustomersPaymentsCall {
  static Future<ApiCallResponse> call({
    String? bearerToken = '',
    String? esco = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Get Stripe Customers Payments',
      apiUrl:
          'https://simt-j-accounts-qa.fly.dev/stripe/customers/payment/${esco}',
      callType: ApiCallType.GET,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${bearerToken}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? allRecords(dynamic response) => getJsonField(
        response,
        r'''$[*]''',
        true,
      ) as List?;
}

class SendPaymentAdminCall {
  static Future<ApiCallResponse> call({
    String? bearerToken = '',
    double? amount,
    String? description = '',
    String? customerEmail = '',
    String? submitAt = '',
  }) async {
    final ffApiRequestBody = '''
{
  "amount": "${amount}",
  "customerEmail": "${customerEmail}",
  "description": "${description}",
  "submitAt": "${submitAt}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Send Payment Admin',
      apiUrl: 'https://simt-j-accounts-qa.fly.dev/admin/payment',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${bearerToken}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
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
      apiUrl: 'https://simt-j-accounts-qa.fly.dev/account',
      callType: ApiCallType.GET,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${bearerToken}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? allRecords(dynamic response) => getJsonField(
        response,
        r'''$[*]''',
        true,
      ) as List?;
}

class GetMonthlyUsageCall {
  static Future<ApiCallResponse> call({
    String? bearerToken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Get Monthly Usage',
      apiUrl: 'https://simt-j-accounts-qa.fly.dev/monthlyUsage',
      callType: ApiCallType.GET,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${bearerToken}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? allRecords(dynamic response) => getJsonField(
        response,
        r'''$[*]''',
        true,
      ) as List?;
}

class GetMonthlyCostCall {
  static Future<ApiCallResponse> call({
    String? bearerToken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Get Monthly Cost',
      apiUrl: 'https://simt-j-accounts-qa.fly.dev/monthlyCost',
      callType: ApiCallType.GET,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${bearerToken}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? allRecords(dynamic response) => getJsonField(
        response,
        r'''$[*]''',
        true,
      ) as List?;
}

class GetTariffsCall {
  static Future<ApiCallResponse> call({
    String? bearerToken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Get Tariffs',
      apiUrl: 'https://simt-j-accounts-qa.fly.dev/tariffs',
      callType: ApiCallType.GET,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${bearerToken}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? allRecords(dynamic response) => getJsonField(
        response,
        r'''$[*]''',
        true,
      ) as List?;
}

class GetTopupsCall {
  static Future<ApiCallResponse> call({
    String? bearerToken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Get Topups',
      apiUrl: 'https://simt-j-accounts-qa.fly.dev/topups',
      callType: ApiCallType.GET,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${bearerToken}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? allRecords(dynamic response) => getJsonField(
        response,
        r'''$[*]''',
        true,
      ) as List?;
}

class GetPaymentsCall {
  static Future<ApiCallResponse> call({
    String? bearerToken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Get Payments',
      apiUrl: 'https://simt-j-accounts-qa.fly.dev/payments',
      callType: ApiCallType.GET,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${bearerToken}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
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
    String? esco = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Create Stripe Checkout Session',
      apiUrl:
          'https://simt-j-accounts-qa.fly.dev/stripe/customers/checkoutSession/${esco}',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${bearerToken}',
      },
      params: {},
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
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
    String? esco = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Delete Customers Payment Method',
      apiUrl:
          'https://simt-j-accounts-qa.fly.dev/stripe/customers/paymentMethods/${esco}/${id}',
      callType: ApiCallType.DELETE,
      headers: {
        'Authorization': 'Bearer ${bearerToken}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class CustomerDetailsConfirmedCall {
  static Future<ApiCallResponse> call({
    String? bearerToken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Customer details confirmed',
      apiUrl: 'https://simt-j-accounts-qa.fly.dev/customer/detailsConfirmed',
      callType: ApiCallType.PUT,
      headers: {
        'Authorization': 'Bearer ${bearerToken}',
      },
      params: {},
      bodyType: BodyType.NONE,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class UpdateCustomerEmailCall {
  static Future<ApiCallResponse> call({
    String? bearerToken = '',
    String? email = '',
  }) async {
    final ffApiRequestBody = '''
{
  "newEmail": "${email}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Update Customer Email',
      apiUrl: 'https://simt-j-accounts-qa.fly.dev/customer/email',
      callType: ApiCallType.PUT,
      headers: {
        'Authorization': 'Bearer ${bearerToken}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class UpdateCustomerFullnameCall {
  static Future<ApiCallResponse> call({
    String? bearerToken = '',
    String? fullname = '',
  }) async {
    final ffApiRequestBody = '''
{
  "fullname": "${fullname}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Update Customer Fullname',
      apiUrl: 'https://simt-j-accounts-qa.fly.dev/customer/fullname',
      callType: ApiCallType.PUT,
      headers: {
        'Authorization': 'Bearer ${bearerToken}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
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
          'https://simt-j-accounts-qa.fly.dev/wallet/${walletId}/topupPreference',
      callType: ApiCallType.PUT,
      headers: {
        'Authorization': 'Bearer ${bearerToken}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GenerateTokenForImpersonateCall {
  static Future<ApiCallResponse> call({
    String? bearerToken = '',
    String? customerEmail = '',
  }) async {
    final ffApiRequestBody = '''
{
  "customerEmail": "${customerEmail}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Generate Token for Impersonate',
      apiUrl: 'https://simt-j-accounts-qa.fly.dev/admin/generateToken',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${bearerToken}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
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
      apiUrl: 'https://simt-j-accounts-qa.fly.dev/wallet',
      callType: ApiCallType.GET,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${bearerToken}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
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
          'https://simt-j-accounts-qa.fly.dev/customer/invite/${inviteToken}',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
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
          'https://simt-j-accounts-qa.fly.dev/contract/${id}/signing-embed.html',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${bearerToken}',
      },
      params: {
        'termsSubtype': termsSubtype,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
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
      apiUrl: 'https://simt-j-accounts-qa.fly.dev/contractTerms',
      callType: ApiCallType.GET,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${bearerToken}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
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

String _toEncodable(dynamic item) {
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}
