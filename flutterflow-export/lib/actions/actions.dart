import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/api_requests/api_manager.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future handleMyEnergyApiCallFailure(
  BuildContext context, {
  required String? wwwAuthenticateHeader,
  required int? httpStatusCode,
}) async {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        'HandleFailure action block triggered',
        style: TextStyle(),
      ),
      duration: Duration(milliseconds: 4000),
      backgroundColor: FlutterFlowTheme.of(context).secondary,
    ),
  );
  if ((httpStatusCode == 401) &&
      functions.isJwtExpired(wwwAuthenticateHeader!)) {
    context.goNamed('loginPage');
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Unknown and unhandled api call error encountered',
          style: TextStyle(),
        ),
        duration: Duration(milliseconds: 4000),
        backgroundColor: FlutterFlowTheme.of(context).secondary,
      ),
    );
  }
}

Future<bool?> getAndSaveAccounts(BuildContext context) async {
  ApiCallResponse? getAccountsResponse;
  dynamic? supplyContract;

  // Get a fresh copy of the customers accounts on every login here.  Put it in the app state with a caching timestamp.
  getAccountsResponse = await GetCustomersAccountsCall.call(
    bearerToken: currentJwtToken,
  );
  if ((getAccountsResponse?.succeeded ?? true)) {
    await Future.delayed(const Duration(milliseconds: 500));
    supplyContract = await actions.getContractsByTypeFromAccountsJSON(
      getJsonField(
        (getAccountsResponse?.jsonBody ?? ''),
        r'''$.accounts''',
        true,
      )!,
      'supply',
    );
    FFAppState().accountsJSON = getJsonField(
      (getAccountsResponse?.jsonBody ?? ''),
      r'''$.accounts''',
      true,
    )!
        .toList()
        .cast<dynamic>();
    FFAppState().meterSerials = getJsonField(
      (getAccountsResponse?.jsonBody ?? ''),
      r'''$.meterSerials''',
    );
    FFAppState().supplyContractSigned = getJsonField(
          supplyContract,
          r'''$.signedDate''',
        ) !=
        null;
    return true;
  } else {
    await action_blocks.handleMyEnergyApiCallFailure(
      context,
      wwwAuthenticateHeader:
          (getAccountsResponse?.getHeader('www-authenticate') ?? ''),
      httpStatusCode: (getAccountsResponse?.statusCode ?? 200),
    );
    return false;
  }
}
