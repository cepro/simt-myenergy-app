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
    _safeInit(() {
      _sites = prefs
              .getStringList('ff_sites')
              ?.map((x) {
                try {
                  return SiteStruct.fromSerializableMap(jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _sites;
    });
    _safeInit(() {
      if (prefs.containsKey('ff_site')) {
        try {
          final serializedData = prefs.getString('ff_site') ?? '{}';
          _site = SiteStruct.fromSerializableMap(jsonDecode(serializedData));
        } catch (e) {
          print("Can't decode persisted data type. Error: $e.");
        }
      }
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

  List<SiteStruct> _sites = [];
  List<SiteStruct> get sites => _sites;
  set sites(List<SiteStruct> _value) {
    _sites = _value;
    prefs.setStringList('ff_sites', _value.map((x) => x.serialize()).toList());
  }

  void addToSites(SiteStruct _value) {
    _sites.add(_value);
    prefs.setStringList('ff_sites', _sites.map((x) => x.serialize()).toList());
  }

  void removeFromSites(SiteStruct _value) {
    _sites.remove(_value);
    prefs.setStringList('ff_sites', _sites.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromSites(int _index) {
    _sites.removeAt(_index);
    prefs.setStringList('ff_sites', _sites.map((x) => x.serialize()).toList());
  }

  void updateSitesAtIndex(
    int _index,
    SiteStruct Function(SiteStruct) updateFn,
  ) {
    _sites[_index] = updateFn(_sites[_index]);
    prefs.setStringList('ff_sites', _sites.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInSites(int _index, SiteStruct _value) {
    _sites.insert(_index, _value);
    prefs.setStringList('ff_sites', _sites.map((x) => x.serialize()).toList());
  }

  SiteStruct _site = SiteStruct.fromSerializableMap(jsonDecode('{}'));
  SiteStruct get site => _site;
  set site(SiteStruct _value) {
    _site = _value;
    prefs.setString('ff_site', _value.serialize());
  }

  void updateSiteStruct(Function(SiteStruct) updateFn) {
    updateFn(_site);
    prefs.setString('ff_site', _site.serialize());
  }

  List<PropertyStruct> _properties = [];
  List<PropertyStruct> get properties => _properties;
  set properties(List<PropertyStruct> _value) {
    _properties = _value;
    prefs.setStringList(
        'ff_properties', _value.map((x) => x.serialize()).toList());
  }

  void addToProperties(PropertyStruct _value) {
    _properties.add(_value);
    prefs.setStringList(
        'ff_properties', _properties.map((x) => x.serialize()).toList());
  }

  void removeFromProperties(PropertyStruct _value) {
    _properties.remove(_value);
    prefs.setStringList(
        'ff_properties', _properties.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromProperties(int _index) {
    _properties.removeAt(_index);
    prefs.setStringList(
        'ff_properties', _properties.map((x) => x.serialize()).toList());
  }

  void updatePropertiesAtIndex(
    int _index,
    PropertyStruct Function(PropertyStruct) updateFn,
  ) {
    _properties[_index] = updateFn(_properties[_index]);
    prefs.setStringList(
        'ff_properties', _properties.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInProperties(int _index, PropertyStruct _value) {
    _properties.insert(_index, _value);
    prefs.setStringList(
        'ff_properties', _properties.map((x) => x.serialize()).toList());
  }

  PropertyStruct _property = PropertyStruct();
  PropertyStruct get property => _property;
  set property(PropertyStruct _value) {
    _property = _value;
  }

  void updatePropertyStruct(Function(PropertyStruct) updateFn) {
    updateFn(_property);
  }

  String _customerId = '';
  String get customerId => _customerId;
  set customerId(String _value) {
    _customerId = _value;
    prefs.setString('ff_customerId', _value);
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
