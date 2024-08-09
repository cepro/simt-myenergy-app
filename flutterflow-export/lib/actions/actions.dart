import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/api_requests/api_manager.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
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

Future<bool?> getCustomerDetailsAndInitAppState(BuildContext context) async {
  ApiCallResponse? getAccountsResponse;
  ApiCallResponse? getMonthlyUsageResponse;
  List<AccountStruct>? accounts;
  List<MonthlyUsageStruct>? monthlyUsages;
  String? getHostnameResponse;

  await Future.wait([
    Future(() async {
      // Get a fresh copy of the customers accounts on every login here.  Put it in the app state with a caching timestamp.
      getAccountsResponse = await GetCustomersAccountsCall.call(
        bearerToken: currentJwtToken,
      );
    }),
    Future(() async {
      getMonthlyUsageResponse = await GetMonthlyUsageCall.call(
        bearerToken: currentJwtToken,
      );
    }),
  ]);
  if ((getAccountsResponse?.succeeded ?? true) &&
      (getMonthlyUsageResponse?.succeeded ?? true)) {
    await Future.delayed(const Duration(milliseconds: 500));
    accounts = await actions.accountsJSONToAccountsDataType(
      getJsonField(
        (getAccountsResponse?.jsonBody ?? ''),
        r'''$.accounts''',
        true,
      )!,
    );
    monthlyUsages = await actions.monthlyUsageJSONToDataType(
      (getMonthlyUsageResponse?.jsonBody ?? ''),
    );
    // We get this on the login page but lets get it again to be sure it's set when all other app state is set.
    getHostnameResponse = await actions.getHostname();
    FFAppState().meters = getJsonField(
      (getAccountsResponse?.jsonBody ?? ''),
      r'''$.meters''',
    );
    FFAppState().supplyContractSigned = functions
                .getContractByType(accounts!.toList(), 'supply')
                ?.signedDate !=
            null &&
        functions.getContractByType(accounts!.toList(), 'supply')?.signedDate !=
            '';
    FFAppState().accounts = accounts!.toList().cast<AccountStruct>();
    FFAppState().properties = functions
        .getPropertiesFromAccounts(accounts!.toList())
        .toList()
        .cast<PropertyStruct>();
    FFAppState().sites = functions
        .getSitesFromProperties(
            functions.getPropertiesFromAccounts(accounts!.toList()).toList())
        .toList()
        .cast<SiteStruct>();
    FFAppState().customerId = getJsonField(
      (getAccountsResponse?.jsonBody ?? ''),
      r'''$.customer.customerId''',
    ).toString().toString();
    FFAppState().monthlyUsage =
        monthlyUsages!.toList().cast<MonthlyUsageStruct>();
    FFAppState().customerStatus = getJsonField(
      (getAccountsResponse?.jsonBody ?? ''),
      r'''$.customer.status''',
    ).toString().toString();
    FFAppState().hostname = getHostnameResponse!;
    FFAppState().site = functions.hostnameToSiteCode(getHostnameResponse);
    FFAppState().isCeproUser = getJsonField(
      (getAccountsResponse?.jsonBody ?? ''),
      r'''$.customer.isCeproUser''',
    );
    FFAppState().siteName = () {
      if (FFAppState().site == SiteCodeEnum.wlce) {
        return 'Water Lilies';
      } else if (FFAppState().site == SiteCodeEnum.hmce) {
        return 'Hazelmead';
      } else {
        return 'unknown';
      }
    }();
    FFAppState().esco = functions.hostnameToEscoCode(getHostnameResponse);
    FFAppState().escoName = () {
      if (FFAppState().esco == EscoCodeEnum.wlce) {
        return 'Water Lilies';
      } else if (FFAppState().esco == EscoCodeEnum.hmce) {
        return 'Hazelmead';
      } else {
        return 'unknown';
      }
    }();
    FFAppState().escos = functions
        .getEscosFromProperties(
            functions.getPropertiesFromAccounts(accounts!.toList()).toList())
        .toList()
        .cast<EscoStruct>();
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

Future<String?> contractSignEmbed(
  BuildContext context, {
  required String? contractId,
  String? termsSubtype,
}) async {
  ApiCallResponse? contractSigningEmbedResponse;

  contractSigningEmbedResponse = await ContractSigningEmbedCall.call(
    bearerToken: currentJwtToken,
    id: contractId,
    termsSubtype: termsSubtype,
  );

  if ((contractSigningEmbedResponse?.succeeded ?? true)) {
    return (contractSigningEmbedResponse?.bodyText ?? '');
  }

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        'Failed:${(contractSigningEmbedResponse?.bodyText ?? '')}',
        style: TextStyle(),
      ),
      duration: Duration(milliseconds: 4000),
      backgroundColor: FlutterFlowTheme.of(context).secondary,
    ),
  );

  return null;
}

Future<bool> getAndSaveContractTerms(BuildContext context) async {
  ApiCallResponse? getContractTermsResponse;
  List<ContractTermsStruct>? contractTermsDataType;

  getContractTermsResponse = await ContractTermsLatestCall.call(
    bearerToken: currentJwtToken,
  );

  if ((getContractTermsResponse?.succeeded ?? true)) {
    await Future.delayed(const Duration(milliseconds: 500));
    contractTermsDataType =
        await actions.contractTermsJSONToContractTermsDataType(
      (getContractTermsResponse?.jsonBody ?? ''),
    );
    FFAppState().contractTerms =
        contractTermsDataType!.toList().cast<ContractTermsStruct>();
  } else {
    await action_blocks.handleMyEnergyApiCallFailure(
      context,
      wwwAuthenticateHeader:
          (getContractTermsResponse?.getHeader('www-authenticate') ?? ''),
      httpStatusCode: (getContractTermsResponse?.statusCode ?? 200),
    );
    return false;
  }

  return true;
}

Future clearAppState(BuildContext context) async {
  // Clear All App State
  FFAppState().meters = null;
  FFAppState().supplyContractSigned = false;
  FFAppState().accounts = [];
  FFAppState().sites = [];
  FFAppState().properties = [];
  FFAppState().monthlyUsage = [];
  FFAppState().monthlyUsageJSON = null;
  FFAppState().customerStatus = '';
  FFAppState().isCeproUser = false;
  FFAppState().contractTerms = [];
}
