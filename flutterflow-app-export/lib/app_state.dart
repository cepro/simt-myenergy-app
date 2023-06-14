import 'package:flutter/material.dart';
import 'flutter_flow/request_manager.dart';
import 'backend/api_requests/api_manager.dart';
import 'backend/supabase/supabase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static final FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _isCacheOverride =
          prefs.getBool('ff_isCacheOverride') ?? _isCacheOverride;
    });
    _safeInit(() {
      _jwtToken = prefs.getString('ff_jwtToken') ?? _jwtToken;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  bool _isCacheOverride = true;
  bool get isCacheOverride => _isCacheOverride;
  set isCacheOverride(bool _value) {
    _isCacheOverride = _value;
    prefs.setBool('ff_isCacheOverride', _value);
  }

  DateTime? _lastCacheTime = DateTime.fromMillisecondsSinceEpoch(946659600000);
  DateTime? get lastCacheTime => _lastCacheTime;
  set lastCacheTime(DateTime? _value) {
    _lastCacheTime = _value;
  }

  String _jwtToken = '';
  String get jwtToken => _jwtToken;
  set jwtToken(String _value) {
    _jwtToken = _value;
    prefs.setString('ff_jwtToken', _value);
  }

  final _paymentMethodsQueryAppLevelManager =
      FutureRequestManager<ApiCallResponse>();
  Future<ApiCallResponse> paymentMethodsQueryAppLevel({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<ApiCallResponse> Function() requestFn,
  }) =>
      _paymentMethodsQueryAppLevelManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearPaymentMethodsQueryAppLevelCache() =>
      _paymentMethodsQueryAppLevelManager.clear();
  void clearPaymentMethodsQueryAppLevelCacheKey(String? uniqueKey) =>
      _paymentMethodsQueryAppLevelManager.clearRequest(uniqueKey);
}

LatLng? _latLngFromString(String? val) {
  if (val == null) {
    return null;
  }
  final split = val.split(',');
  final lat = double.parse(split.first);
  final lng = double.parse(split.last);
  return LatLng(lat, lng);
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
