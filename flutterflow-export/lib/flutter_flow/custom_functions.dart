import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/auth/supabase_auth/auth_util.dart';

bool isJwtExpired(String wwwAuthenticateHeader) {
  return wwwAuthenticateHeader.contains('Jwt expired');
}

int arrayLengthOrNegativeOneIfNotArray(dynamic responseJSON) {
  // Given an argument of type JSON compute the length of the JSON if it is an array
  if (responseJSON is List) {
    return responseJSON.length;
  } else {
    // using -1 to indicate argument passed was either null or not a List.
    // -1 is a precise value that we can set up a definite comparison against in the UI.
    return -1;
  }
}

List<PropertyStruct> getPropertiesFromAccounts(List<AccountStruct> accounts) {
  return accounts
      .map((a) => a.property)
      // remove duplicates by converting to a Set
      .toSet()
      .toList();
}

bool isListEmpty(List<dynamic>? jsonList) {
  return jsonList == null || jsonList.length == 0;
}

List<EscoStruct> getEscosFromProperties(List<PropertyStruct> properties) {
  return properties
      .map((p) => p.esco)
      // remove duplicates by converting to a Set
      .toSet()
      .toList();
}

ContractStruct? getContractByType(
  List<AccountStruct> accounts,
  String type,
) {
  AccountStruct? account = accounts.firstWhere(
      (account) => account.contract.type == type,
      orElse: () => new AccountStruct());
  return account.contract;
}

EscoCodeEnum hostnameToEscoCode(String? hostname) {
  if (hostname == null) return EscoCodeEnum.unknown;

  if (hostname.endsWith('.waterlilies.energy')) {
    return EscoCodeEnum.wlce;
  }

  if (hostname.endsWith('.hazelmead.energy')) {
    return EscoCodeEnum.hmce;
  }

  // local testing from bin/run-local default to wlce:
  if (hostname == '0.0.0.0') {
    return EscoCodeEnum.wlce;
  }

  return EscoCodeEnum.unknown;
}

String formatGBPAmount(double amountGBP) {
  var f = NumberFormat("##0.00", "en_GB");
  return "£" + f.format(amountGBP);
}

bool isPrepayMode(MeterStruct? meter) {
  return meter != null && meter.prepayEnabled == true;
}

bool isPasswordWeak(String password) {
  // Keep rules in sync with the supabase auth password rules.
  // Currently only a password length check:
  return password.length < 8;
}

bool escoInEscosList(
  List<EscoStruct> escos,
  EscoCodeEnum esco,
) {
  return escos.any((e) => e.code == esco);
}

String supportEmail(EscoCodeEnum esco) {
  if (esco == EscoCodeEnum.wlce) {
    return 'hello@waterlilies.energy';
  } else if (esco == EscoCodeEnum.hmce) {
    return 'hello@hazelmead.energy';
  } else {
    return 'hello@cepro.energy';
  }
}

String newLineChar() {
  return "\n";
}

TariffStruct? tariffForDate(
  List<TariffStruct> tariffList,
  DateTime tariffDate,
) {
  // sort descending
  tariffList.sort((a, b) => b.periodStart!.compareTo(a.periodStart!));

  for (var tariff in tariffList) {
    // looping in desending order so until:
    if (tariffDate.isAfter(tariff.periodStart!) ||
        tariffDate == tariff.periodStart) {
      return tariff;
    }
  }

  return null;
}

DateTime nowDateTime() {
  return DateTime.now();
}

String formatGBPPenceAmount(double amountGBP) {
  var f = NumberFormat("##0.0", "en_GB");
  return f.format(amountGBP * 100) + "p";
}

String monthlyCostsTooltipPricingText(
  MonthlyCostStruct monthlyCostsItem,
  TariffsStruct tariffs,
  bool showRate,
  bool showPower,
) {
  /******        Microgrid Rate      *********/

  TariffStruct? microgridTariff = tariffForDate(
      tariffs.microgridTariffs.toList(), monthlyCostsItem.monthTyped!);
  if (microgridTariff == null) {
    throw 'microgrid tariff not found for this month';
  }

  double microgridRate;
  if (showRate) {
    microgridRate = microgridTariff.unitRate;
  } else {
    microgridRate = microgridTariff.standingCharge;
  }

  /******        Benchmark Rate      *********/

  TariffStruct? benchmarkTariff = tariffForDate(
      tariffs.benchmarkTariffs.toList(), monthlyCostsItem.monthTyped!);
  if (benchmarkTariff == null) {
    throw 'benchmark tariff not found for this month';
  }

  double benchmarkRate;
  if (showRate) {
    benchmarkRate = benchmarkTariff.unitRate;
  } else {
    benchmarkRate = benchmarkTariff.standingCharge;
  }

  /******        Microgrid Charge      *********/

  double microgridCharge;
  if (showRate) {
    microgridCharge = showPower
        ? monthlyCostsItem.microgridPower
        : monthlyCostsItem.microgridHeat;
  } else {
    microgridCharge = monthlyCostsItem.microgridStandingCharge;
  }

  return 'Benchmark rate: ${formatGBPPenceAmount(benchmarkRate)}'
      '${newLineChar()}'
      'Microgrid rate: ${formatGBPPenceAmount(microgridRate)}'
      '${newLineChar()}'
      'Microgrid charge: ${formatGBPAmount(microgridCharge)}';
}
