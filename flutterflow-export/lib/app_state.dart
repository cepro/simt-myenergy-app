import 'package:flutter/material.dart';
import '/backend/schema/structs/index.dart';
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
    _safeInit(() {
      _accounts = prefs
              .getStringList('ff_accounts')
              ?.map((x) {
                try {
                  return AccountStruct.fromSerializableMap(jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _accounts;
    });
    _safeInit(() {
      _contractTerms = prefs
              .getStringList('ff_contractTerms')
              ?.map((x) {
                try {
                  return ContractTermsStruct.fromSerializableMap(jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _contractTerms;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

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

  List<AccountStruct> _accounts = [];
  List<AccountStruct> get accounts => _accounts;
  set accounts(List<AccountStruct> _value) {
    _accounts = _value;
    prefs.setStringList(
        'ff_accounts', _value.map((x) => x.serialize()).toList());
  }

  void addToAccounts(AccountStruct _value) {
    _accounts.add(_value);
    prefs.setStringList(
        'ff_accounts', _accounts.map((x) => x.serialize()).toList());
  }

  void removeFromAccounts(AccountStruct _value) {
    _accounts.remove(_value);
    prefs.setStringList(
        'ff_accounts', _accounts.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromAccounts(int _index) {
    _accounts.removeAt(_index);
    prefs.setStringList(
        'ff_accounts', _accounts.map((x) => x.serialize()).toList());
  }

  void updateAccountsAtIndex(
    int _index,
    AccountStruct Function(AccountStruct) updateFn,
  ) {
    _accounts[_index] = updateFn(_accounts[_index]);
    prefs.setStringList(
        'ff_accounts', _accounts.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInAccounts(int _index, AccountStruct _value) {
    _accounts.insert(_index, _value);
    prefs.setStringList(
        'ff_accounts', _accounts.map((x) => x.serialize()).toList());
  }

  List<ContractTermsStruct> _contractTerms = [];
  List<ContractTermsStruct> get contractTerms => _contractTerms;
  set contractTerms(List<ContractTermsStruct> _value) {
    _contractTerms = _value;
    prefs.setStringList(
        'ff_contractTerms', _value.map((x) => x.serialize()).toList());
  }

  void addToContractTerms(ContractTermsStruct _value) {
    _contractTerms.add(_value);
    prefs.setStringList(
        'ff_contractTerms', _contractTerms.map((x) => x.serialize()).toList());
  }

  void removeFromContractTerms(ContractTermsStruct _value) {
    _contractTerms.remove(_value);
    prefs.setStringList(
        'ff_contractTerms', _contractTerms.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromContractTerms(int _index) {
    _contractTerms.removeAt(_index);
    prefs.setStringList(
        'ff_contractTerms', _contractTerms.map((x) => x.serialize()).toList());
  }

  void updateContractTermsAtIndex(
    int _index,
    ContractTermsStruct Function(ContractTermsStruct) updateFn,
  ) {
    _contractTerms[_index] = updateFn(_contractTerms[_index]);
    prefs.setStringList(
        'ff_contractTerms', _contractTerms.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInContractTerms(int _index, ContractTermsStruct _value) {
    _contractTerms.insert(_index, _value);
    prefs.setStringList(
        'ff_contractTerms', _contractTerms.map((x) => x.serialize()).toList());
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
