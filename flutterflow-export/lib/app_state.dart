import 'package:flutter/material.dart';
import 'backend/api_requests/api_manager.dart';
import 'backend/supabase/supabase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'dart:convert';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _accountsJSON = prefs.getStringList('ff_accountsJSON')?.map((x) {
            try {
              return jsonDecode(x);
            } catch (e) {
              print("Can't decode persisted json. Error: $e.");
              return {};
            }
          }).toList() ??
          _accountsJSON;
    });
    _safeInit(() {
      _supplyContractSigned =
          prefs.getBool('ff_supplyContractSigned') ?? _supplyContractSigned;
    });
    _safeInit(() {
      if (prefs.containsKey('ff_meterSerials')) {
        try {
          _meterSerials = jsonDecode(prefs.getString('ff_meterSerials') ?? '');
        } catch (e) {
          print("Can't decode persisted json. Error: $e.");
        }
      }
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  List<dynamic> _accountsJSON = [];
  List<dynamic> get accountsJSON => _accountsJSON;
  set accountsJSON(List<dynamic> _value) {
    _accountsJSON = _value;
    prefs.setStringList(
        'ff_accountsJSON', _value.map((x) => jsonEncode(x)).toList());
  }

  void addToAccountsJSON(dynamic _value) {
    _accountsJSON.add(_value);
    prefs.setStringList(
        'ff_accountsJSON', _accountsJSON.map((x) => jsonEncode(x)).toList());
  }

  void removeFromAccountsJSON(dynamic _value) {
    _accountsJSON.remove(_value);
    prefs.setStringList(
        'ff_accountsJSON', _accountsJSON.map((x) => jsonEncode(x)).toList());
  }

  void removeAtIndexFromAccountsJSON(int _index) {
    _accountsJSON.removeAt(_index);
    prefs.setStringList(
        'ff_accountsJSON', _accountsJSON.map((x) => jsonEncode(x)).toList());
  }

  void updateAccountsJSONAtIndex(
    int _index,
    dynamic Function(dynamic) updateFn,
  ) {
    _accountsJSON[_index] = updateFn(_accountsJSON[_index]);
    prefs.setStringList(
        'ff_accountsJSON', _accountsJSON.map((x) => jsonEncode(x)).toList());
  }

  void insertAtIndexInAccountsJSON(int _index, dynamic _value) {
    _accountsJSON.insert(_index, _value);
    prefs.setStringList(
        'ff_accountsJSON', _accountsJSON.map((x) => jsonEncode(x)).toList());
  }

  bool _supplyContractSigned = false;
  bool get supplyContractSigned => _supplyContractSigned;
  set supplyContractSigned(bool _value) {
    _supplyContractSigned = _value;
    prefs.setBool('ff_supplyContractSigned', _value);
  }

  dynamic _meterSerials;
  dynamic get meterSerials => _meterSerials;
  set meterSerials(dynamic _value) {
    _meterSerials = _value;
    prefs.setString('ff_meterSerials', jsonEncode(_value));
  }
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
