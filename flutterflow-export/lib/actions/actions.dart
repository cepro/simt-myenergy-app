import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/api_requests/api_manager.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/components/solar_contract_choose_or_view_modal/solar_contract_choose_or_view_modal_widget.dart';
import '/components/supply_contract_sign_or_view_modal/supply_contract_sign_or_view_modal_widget.dart';
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
    context.goNamed('LoginPage');
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
  String? userToken;
  ApiCallResponse? getAccountsResponse;
  List<AccountStruct>? accounts;
  CustomerStruct? customerToDataTypeResponse;
  String? getHostnameResponse;

  userToken = await actions.activeUserToken();
  // Get a fresh copy of the customers accounts on every login here.  Put it in the app state with a caching timestamp.
  getAccountsResponse = await GetCustomersAccountsCall.call(
    bearerToken: userToken,
  );

  if ((getAccountsResponse?.succeeded ?? true)) {
    await Future.delayed(const Duration(milliseconds: 500));
    accounts = await actions.accountsJSONToAccountsDataType(
      getJsonField(
        (getAccountsResponse?.jsonBody ?? ''),
        r'''$.accounts''',
        true,
      )!,
    );
    customerToDataTypeResponse = await actions.customerJSONToDataType(
      getJsonField(
        (getAccountsResponse?.jsonBody ?? ''),
        r'''$.customer''',
      ),
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
    FFAppState().hostname = getHostnameResponse!;
    FFAppState().isCeproUser = getJsonField(
      (getAccountsResponse?.jsonBody ?? ''),
      r'''$.customer.isCeproUser''',
    );
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
    FFAppState().customer = customerToDataTypeResponse!;
    FFAppState().solarContractSigned = functions
                .getContractByType(accounts!.toList(), 'solar')
                ?.signedDate !=
            null &&
        functions.getContractByType(accounts!.toList(), 'solar')?.signedDate !=
            '';
    FFAppState().solarInstallations = getJsonField(
      (getAccountsResponse?.jsonBody ?? ''),
      r'''$.solarInstallations''',
    );
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
    impersonating: FFAppState().impersonationToken != null &&
        FFAppState().impersonationToken != '',
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
    bearerToken: FFAppState().impersonationToken != null &&
            FFAppState().impersonationToken != ''
        ? FFAppState().impersonationToken
        : currentJwtToken,
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
  FFAppState().properties = [];
  FFAppState().monthlyUsage = [];
  FFAppState().isCeproUser = false;
  FFAppState().contractTerms = [];
  FFAppState().customer = CustomerStruct();
  FFAppState().impersonationEmail = '';
  FFAppState().impersonationToken = '';
  FFAppState().property = PropertyStruct();
  FFAppState().monthlyCosts = [];
  FFAppState().tariffs = TariffsStruct();
  FFAppState().solarContractSigned = false;
  FFAppState().haveSupplyContract = false;
  FFAppState().haveSolarContract = false;
  FFAppState().impersonationPhone = '';
  FFAppState().solarInstallations = null;
  FFAppState().monthlyCostsLoading = false;
  FFAppState().monthlyUsageLoading = false;
  FFAppState().lastMonthlyCostAndUsageLoad = functions.twoThousandDateTime();
}

Future ceproUserOnly(BuildContext context) async {
  if (FFAppState().isCeproUser) {
    return;
  }

  context.pushNamed('HomePage');

  return;
}

Future checkAndBlockWriteableAPICall(BuildContext context) async {
  if (FFAppState().impersonationToken == null ||
      FFAppState().impersonationToken == '') {
    return;
  }

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        'Blocked write API call in Impersonation mode.',
        style: TextStyle(),
      ),
      duration: Duration(milliseconds: 4000),
      backgroundColor: FlutterFlowTheme.of(context).secondary,
    ),
  );
  await actions.breakActionChain();
  return;
}

Future openSupplyContract(BuildContext context) async {
  ContractTermsStruct? supplyContractTerms;

  if (FFAppState().supplyContractSigned) {
    await actions.openPDF(
      functions
          .getContractByType(FFAppState().accounts.toList(), 'supply')!
          .signedContractURL,
    );
  } else {
    await showDialog(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          elevation: 0,
          insetPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          alignment: AlignmentDirectional(0.0, 0.0)
              .resolve(Directionality.of(context)),
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child: SupplyContractSignOrViewModalWidget(
              terms: FFAppState()
                  .contractTerms
                  .where((e) => e.type == 'supply')
                  .toList()
                  .firstOrNull!,
              contract: functions.getContractByType(
                  FFAppState().accounts.toList(), 'supply')!,
            ),
          ),
        );
      },
    );

    supplyContractTerms = await actions.getTermsByTypeAndSubtype(
      FFAppState().contractTerms.toList(),
      'supply',
      null,
    );
    // This action triggers a page rebuild so that the progress task count is recomputed. Without this and after a contract is signed the oboard progress does not update.
    //
    // Seems there must be a more elegant way to do this but for now this works.
    //
    // App state update doesn't change anything as it just sets the supplyContractSigned value to the value it already is.
    // Trigger Page Rebuild for Onboard Progress
    FFAppState().supplyContractSigned = FFAppState().supplyContractSigned;
    FFAppState().update(() {});
  }
}

Future openSolarContract(BuildContext context) async {
  ContractTermsStruct? solarContractTerms;

  if (FFAppState().solarContractSigned) {
    await actions.openPDF(
      functions
          .getContractByType(FFAppState().accounts.toList(), 'solar')!
          .signedContractURL,
    );
  } else {
    await showDialog(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          elevation: 0,
          insetPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          alignment: AlignmentDirectional(0.0, 0.0)
              .resolve(Directionality.of(context)),
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child: SolarContractChooseOrViewModalWidget(
              contract: functions.getContractByType(
                  FFAppState().accounts.toList(), 'solar')!,
              readOnly: false,
              termsSolar30Year: FFAppState()
                  .contractTerms
                  .where((e) => e.subtype == 'thirty_year')
                  .toList()
                  .firstOrNull!,
              termsSolarShortTerm: FFAppState()
                  .contractTerms
                  .where((e) => e.subtype == 'short_term')
                  .toList()
                  .firstOrNull!,
            ),
          ),
        );
      },
    );

    solarContractTerms = await actions.getTermsByTypeAndSubtype(
      FFAppState().contractTerms.toList(),
      'solar',
      null,
    );
    // This action triggers a page rebuild so that the progress task count is recomputed. Without this and after a contract is signed the oboard progress does not update.
    //
    // Seems there must be a more elegant way to do this but for now this works.
    //
    // App state update doesn't change anything as it just sets the solarContractSigned value to the value it already is.
    // Trigger Page Rebuild for Onboard Progress
    FFAppState().solarContractSigned = FFAppState().solarContractSigned;
    FFAppState().update(() {});
  }
}

Future<bool> getTariffsCostsUsage(BuildContext context) async {
  String? userToken;
  ApiCallResponse? getMonthlyCostResponse;
  ApiCallResponse? getTariffsResponse;
  ApiCallResponse? getMonthlyUsageResponse;
  List<MonthlyCostStruct>? monthlyCostsTyped;
  TariffsStruct? tariffsTyped;
  List<MonthlyUsageStruct>? monthlyUsageTyped;

  userToken = await actions.activeUserToken();
  FFAppState().monthlyCostsLoading = true;
  FFAppState().monthlyUsageLoading = true;
  await Future.wait([
    Future(() async {
      getMonthlyCostResponse = await GetMonthlyCostCall.call(
        bearerToken: userToken,
      );
    }),
    Future(() async {
      getTariffsResponse = await GetTariffsCall.call(
        bearerToken: userToken,
      );
    }),
    Future(() async {
      getMonthlyUsageResponse = await GetMonthlyUsageCall.call(
        bearerToken: userToken,
      );
    }),
  ]);
  if ((getMonthlyCostResponse?.succeeded ?? true) &&
      (getTariffsResponse?.succeeded ?? true) &&
      (getMonthlyUsageResponse?.succeeded ?? true)) {
    await Future.delayed(const Duration(milliseconds: 500));
    monthlyCostsTyped = await actions.monthlyCostJSONToDataType(
      (getMonthlyCostResponse?.jsonBody ?? ''),
    );
    tariffsTyped = await actions.tariffsJSONToDataType(
      (getTariffsResponse?.jsonBody ?? ''),
    );
    monthlyUsageTyped = await actions.monthlyUsageJSONToDataType(
      (getMonthlyUsageResponse?.jsonBody ?? ''),
    );
    FFAppState().tariffs = tariffsTyped!;
    FFAppState().monthlyCosts =
        monthlyCostsTyped!.toList().cast<MonthlyCostStruct>();
    FFAppState().monthlyUsage =
        monthlyUsageTyped!.toList().cast<MonthlyUsageStruct>();
    FFAppState().monthlyCostsLoading = false;
    FFAppState().monthlyUsageLoading = false;
    FFAppState().lastMonthlyCostAndUsageLoad = getCurrentTimestamp;
    FFAppState().update(() {});
    return true;
  } else {
    FFAppState().monthlyCostsLoading = false;
    FFAppState().monthlyUsageLoading = false;
    return false;
  }
}

Future<bool?> setContractStatusFlags(BuildContext context) async {
  FFAppState().supplyContractSigned = (functions.getContractByType(
              FFAppState().accounts.toList(), 'supply') !=
          null) &&
      (functions
                  .getContractByType(FFAppState().accounts.toList(), 'supply')
                  ?.signedDate !=
              null &&
          functions
                  .getContractByType(FFAppState().accounts.toList(), 'supply')
                  ?.signedDate !=
              '');
  FFAppState().haveSupplyContract = functions
              .getContractByType(FFAppState().accounts.toList(), 'supply')
              ?.id !=
          null &&
      functions
              .getContractByType(FFAppState().accounts.toList(), 'supply')
              ?.id !=
          '';
  FFAppState().haveSolarContract = functions
              .getContractByType(FFAppState().accounts.toList(), 'solar')
              ?.id !=
          null &&
      functions
              .getContractByType(FFAppState().accounts.toList(), 'solar')
              ?.id !=
          '';
  FFAppState().solarContractSigned = (functions.getContractByType(
              FFAppState().accounts.toList(), 'solar') !=
          null) &&
      (functions
                  .getContractByType(FFAppState().accounts.toList(), 'solar')
                  ?.signedDate !=
              null &&
          functions
                  .getContractByType(FFAppState().accounts.toList(), 'solar')
                  ?.signedDate !=
              '');
  FFAppState().update(() {});
  return true;
}
