import 'package:flutter/material.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
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
      if (prefs.containsKey('ff_meters')) {
        try {
          _meters = jsonDecode(prefs.getString('ff_meters') ?? '');
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
    _safeInit(() {
      _properties = prefs
              .getStringList('ff_properties')
              ?.map((x) {
                try {
                  return PropertyStruct.fromSerializableMap(jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _properties;
    });
    _safeInit(() {
      _customerId = prefs.getString('ff_customerId') ?? _customerId;
    });
    _safeInit(() {
      _monthlyUsage = prefs
              .getStringList('ff_monthlyUsage')
              ?.map((x) {
                try {
                  return MonthlyUsageStruct.fromSerializableMap(jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _monthlyUsage;
    });
    _safeInit(() {
      _customerStatus = prefs.getString('ff_customerStatus') ?? _customerStatus;
    });
    _safeInit(() {
      _hostname = prefs.getString('ff_hostname') ?? _hostname;
    });
    _safeInit(() {
      _isCeproUser = prefs.getBool('ff_isCeproUser') ?? _isCeproUser;
    });
    _safeInit(() {
      _escos = prefs
              .getStringList('ff_escos')
              ?.map((x) {
                try {
                  return EscoStruct.fromSerializableMap(jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _escos;
    });
    _safeInit(() {
      _escoName = prefs.getString('ff_escoName') ?? _escoName;
    });
    _safeInit(() {
      _esco = prefs.containsKey('ff_esco')
          ? deserializeEnum<EscoCodeEnum>(prefs.getString('ff_esco'))
          : _esco;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  bool _supplyContractSigned = false;
  bool get supplyContractSigned => _supplyContractSigned;
  set supplyContractSigned(bool value) {
    _supplyContractSigned = value;
    prefs.setBool('ff_supplyContractSigned', value);
  }

  dynamic _meters;
  dynamic get meters => _meters;
  set meters(dynamic value) {
    _meters = value;
    prefs.setString('ff_meters', jsonEncode(value));
  }

  List<AccountStruct> _accounts = [];
  List<AccountStruct> get accounts => _accounts;
  set accounts(List<AccountStruct> value) {
    _accounts = value;
    prefs.setStringList(
        'ff_accounts', value.map((x) => x.serialize()).toList());
  }

  void addToAccounts(AccountStruct value) {
    accounts.add(value);
    prefs.setStringList(
        'ff_accounts', _accounts.map((x) => x.serialize()).toList());
  }

  void removeFromAccounts(AccountStruct value) {
    accounts.remove(value);
    prefs.setStringList(
        'ff_accounts', _accounts.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromAccounts(int index) {
    accounts.removeAt(index);
    prefs.setStringList(
        'ff_accounts', _accounts.map((x) => x.serialize()).toList());
  }

  void updateAccountsAtIndex(
    int index,
    AccountStruct Function(AccountStruct) updateFn,
  ) {
    accounts[index] = updateFn(_accounts[index]);
    prefs.setStringList(
        'ff_accounts', _accounts.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInAccounts(int index, AccountStruct value) {
    accounts.insert(index, value);
    prefs.setStringList(
        'ff_accounts', _accounts.map((x) => x.serialize()).toList());
  }

  List<ContractTermsStruct> _contractTerms = [];
  List<ContractTermsStruct> get contractTerms => _contractTerms;
  set contractTerms(List<ContractTermsStruct> value) {
    _contractTerms = value;
    prefs.setStringList(
        'ff_contractTerms', value.map((x) => x.serialize()).toList());
  }

  void addToContractTerms(ContractTermsStruct value) {
    contractTerms.add(value);
    prefs.setStringList(
        'ff_contractTerms', _contractTerms.map((x) => x.serialize()).toList());
  }

  void removeFromContractTerms(ContractTermsStruct value) {
    contractTerms.remove(value);
    prefs.setStringList(
        'ff_contractTerms', _contractTerms.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromContractTerms(int index) {
    contractTerms.removeAt(index);
    prefs.setStringList(
        'ff_contractTerms', _contractTerms.map((x) => x.serialize()).toList());
  }

  void updateContractTermsAtIndex(
    int index,
    ContractTermsStruct Function(ContractTermsStruct) updateFn,
  ) {
    contractTerms[index] = updateFn(_contractTerms[index]);
    prefs.setStringList(
        'ff_contractTerms', _contractTerms.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInContractTerms(int index, ContractTermsStruct value) {
    contractTerms.insert(index, value);
    prefs.setStringList(
        'ff_contractTerms', _contractTerms.map((x) => x.serialize()).toList());
  }

  List<PropertyStruct> _properties = [];
  List<PropertyStruct> get properties => _properties;
  set properties(List<PropertyStruct> value) {
    _properties = value;
    prefs.setStringList(
        'ff_properties', value.map((x) => x.serialize()).toList());
  }

  void addToProperties(PropertyStruct value) {
    properties.add(value);
    prefs.setStringList(
        'ff_properties', _properties.map((x) => x.serialize()).toList());
  }

  void removeFromProperties(PropertyStruct value) {
    properties.remove(value);
    prefs.setStringList(
        'ff_properties', _properties.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromProperties(int index) {
    properties.removeAt(index);
    prefs.setStringList(
        'ff_properties', _properties.map((x) => x.serialize()).toList());
  }

  void updatePropertiesAtIndex(
    int index,
    PropertyStruct Function(PropertyStruct) updateFn,
  ) {
    properties[index] = updateFn(_properties[index]);
    prefs.setStringList(
        'ff_properties', _properties.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInProperties(int index, PropertyStruct value) {
    properties.insert(index, value);
    prefs.setStringList(
        'ff_properties', _properties.map((x) => x.serialize()).toList());
  }

  PropertyStruct _property = PropertyStruct();
  PropertyStruct get property => _property;
  set property(PropertyStruct value) {
    _property = value;
  }

  void updatePropertyStruct(Function(PropertyStruct) updateFn) {
    updateFn(_property);
  }

  String _customerId = '';
  String get customerId => _customerId;
  set customerId(String value) {
    _customerId = value;
    prefs.setString('ff_customerId', value);
  }

  List<MonthlyUsageStruct> _monthlyUsage = [];
  List<MonthlyUsageStruct> get monthlyUsage => _monthlyUsage;
  set monthlyUsage(List<MonthlyUsageStruct> value) {
    _monthlyUsage = value;
    prefs.setStringList(
        'ff_monthlyUsage', value.map((x) => x.serialize()).toList());
  }

  void addToMonthlyUsage(MonthlyUsageStruct value) {
    monthlyUsage.add(value);
    prefs.setStringList(
        'ff_monthlyUsage', _monthlyUsage.map((x) => x.serialize()).toList());
  }

  void removeFromMonthlyUsage(MonthlyUsageStruct value) {
    monthlyUsage.remove(value);
    prefs.setStringList(
        'ff_monthlyUsage', _monthlyUsage.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromMonthlyUsage(int index) {
    monthlyUsage.removeAt(index);
    prefs.setStringList(
        'ff_monthlyUsage', _monthlyUsage.map((x) => x.serialize()).toList());
  }

  void updateMonthlyUsageAtIndex(
    int index,
    MonthlyUsageStruct Function(MonthlyUsageStruct) updateFn,
  ) {
    monthlyUsage[index] = updateFn(_monthlyUsage[index]);
    prefs.setStringList(
        'ff_monthlyUsage', _monthlyUsage.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInMonthlyUsage(int index, MonthlyUsageStruct value) {
    monthlyUsage.insert(index, value);
    prefs.setStringList(
        'ff_monthlyUsage', _monthlyUsage.map((x) => x.serialize()).toList());
  }

  dynamic _monthlyUsageJSON;
  dynamic get monthlyUsageJSON => _monthlyUsageJSON;
  set monthlyUsageJSON(dynamic value) {
    _monthlyUsageJSON = value;
  }

  String _customerStatus = '';
  String get customerStatus => _customerStatus;
  set customerStatus(String value) {
    _customerStatus = value;
    prefs.setString('ff_customerStatus', value);
  }

  String _hostname = '';
  String get hostname => _hostname;
  set hostname(String value) {
    _hostname = value;
    prefs.setString('ff_hostname', value);
  }

  bool _isCeproUser = false;
  bool get isCeproUser => _isCeproUser;
  set isCeproUser(bool value) {
    _isCeproUser = value;
    prefs.setBool('ff_isCeproUser', value);
  }

  List<EscoStruct> _escos = [];
  List<EscoStruct> get escos => _escos;
  set escos(List<EscoStruct> value) {
    _escos = value;
    prefs.setStringList('ff_escos', value.map((x) => x.serialize()).toList());
  }

  void addToEscos(EscoStruct value) {
    escos.add(value);
    prefs.setStringList('ff_escos', _escos.map((x) => x.serialize()).toList());
  }

  void removeFromEscos(EscoStruct value) {
    escos.remove(value);
    prefs.setStringList('ff_escos', _escos.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromEscos(int index) {
    escos.removeAt(index);
    prefs.setStringList('ff_escos', _escos.map((x) => x.serialize()).toList());
  }

  void updateEscosAtIndex(
    int index,
    EscoStruct Function(EscoStruct) updateFn,
  ) {
    escos[index] = updateFn(_escos[index]);
    prefs.setStringList('ff_escos', _escos.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInEscos(int index, EscoStruct value) {
    escos.insert(index, value);
    prefs.setStringList('ff_escos', _escos.map((x) => x.serialize()).toList());
  }

  String _escoName = '';
  String get escoName => _escoName;
  set escoName(String value) {
    _escoName = value;
    prefs.setString('ff_escoName', value);
  }

  EscoCodeEnum? _esco = EscoCodeEnum.unknown;
  EscoCodeEnum? get esco => _esco;
  set esco(EscoCodeEnum? value) {
    _esco = value;
    value != null
        ? prefs.setString('ff_esco', value.serialize())
        : prefs.remove('ff_esco');
  }
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
