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

List<SiteStruct> getSitesFromProperties(List<PropertyStruct> properties) {
  return properties
      .map((p) => p.site)
      // remove duplicates by converting to a Set
      .toSet()
      .toList();
}

bool isListEmpty(List<dynamic>? jsonList) {
  return jsonList == null || jsonList.length == 0;
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

String formatCurrencyAmount(double amount) {
  var f = NumberFormat("###.00", "en_GB");
  return "£" + f.format(amount);
}

bool isPrepayMode(MeterStruct? meter) {
  return meter != null && meter.prepayEnabled == true;
}

bool isPasswordWeak(String password) {
  // Keep rules in sync with the supabase auth password rules.
  // Currently only a password length check:
  return password.length < 8;
}

SiteCodeEnum hostnameToSiteCode(String? hostname) {
  if (hostname == null) return SiteCodeEnum.unknown;

  if (hostname.endsWith('.waterlilies.energy')) {
    return SiteCodeEnum.wlce;
  }

  if (hostname.endsWith('.hazelmead.energy')) {
    return SiteCodeEnum.hmce;
  }

  // local testing from bin/run-local default to wlce:
  if (hostname == '0.0.0.0') {
    return SiteCodeEnum.wlce;
  }

  return SiteCodeEnum.unknown;
}
