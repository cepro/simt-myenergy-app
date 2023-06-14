import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import '/backend/supabase/supabase.dart';
import '/auth/supabase_auth/auth_util.dart';

int jsonArrayLength(dynamic responseJSON) {
  // Given an argument of  type JSON compute the length of the JSON if it is an array
  if (responseJSON is List) {
    return responseJSON.length;
  } else {
    return 0;
  }
}
