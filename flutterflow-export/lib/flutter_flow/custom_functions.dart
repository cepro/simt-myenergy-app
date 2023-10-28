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
