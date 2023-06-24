import 'dart:convert';
import 'dart:typed_data';

import '../../flutter_flow/flutter_flow_util.dart';

import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class GetCustomersPaymentMethodsCall {
  static Future<ApiCallResponse> call({
    String? bearerToken = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'Get Customers Payment Methods',
      apiUrl:
          'https://es2mhcpqgv.eu-west-1.awsapprunner.com/customers/paymentMethods',
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
    );
  }

  static dynamic allRecords(dynamic response) => getJsonField(
        response,
        r'''$[*]''',
        true,
      );
}

class CreateStripeCheckoutSessionCall {
  static Future<ApiCallResponse> call({
    String? bearerToken = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'Create Stripe Checkout Session',
      apiUrl:
          'https://es2mhcpqgv.eu-west-1.awsapprunner.com/customers/checkoutSession',
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
    );
  }

  static dynamic checkoutPageURI(dynamic response) => getJsonField(
        response,
        r'''$.checkoutPageURI''',
      );
}

class DeleteCustomersPaymentMethodCopyCall {
  static Future<ApiCallResponse> call({
    String? id = '',
    String? bearerToken = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'Delete Customers Payment Method Copy',
      apiUrl:
          'https://es2mhcpqgv.eu-west-1.awsapprunner.com/customers/paymentMethods/${id}',
      callType: ApiCallType.DELETE,
      headers: {
        'Authorization': 'Bearer ${bearerToken}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class UpdateTopupPreferencesCall {
  static Future<ApiCallResponse> call({
    String? bearerToken = '',
    int? amount,
    int? threshold,
  }) {
    final body = '''
{
  "amount": ${amount},
  "threshold": ${threshold}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Update Topup Preferences',
      apiUrl: 'https://qecg6jbdmm.eu-west-1.awsapprunner.com/topup',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${bearerToken}',
      },
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class GetTopupPreferencesCall {
  static Future<ApiCallResponse> call({
    String? bearerToken = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'Get Topup Preferences',
      apiUrl: 'https://qecg6jbdmm.eu-west-1.awsapprunner.com/topup',
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
