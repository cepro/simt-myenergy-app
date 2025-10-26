import 'package:flutter/material.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

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
      _accountsAll = prefs
              .getStringList('ff_accountsAll')
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
          _accountsAll;
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
      if (prefs.containsKey('ff_property')) {
        try {
          final serializedData = prefs.getString('ff_property') ?? '{}';
          _property =
              PropertyStruct.fromSerializableMap(jsonDecode(serializedData));
        } catch (e) {
          print("Can't decode persisted data type. Error: $e.");
        }
      }
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
    _safeInit(() {
      _impersonationToken =
          prefs.getString('ff_impersonationToken') ?? _impersonationToken;
    });
    _safeInit(() {
      _impersonationEmail =
          prefs.getString('ff_impersonationEmail') ?? _impersonationEmail;
    });
    _safeInit(() {
      if (prefs.containsKey('ff_customer')) {
        try {
          final serializedData = prefs.getString('ff_customer') ?? '{}';
          _customer =
              CustomerStruct.fromSerializableMap(jsonDecode(serializedData));
        } catch (e) {
          print("Can't decode persisted data type. Error: $e.");
        }
      }
    });
    _safeInit(() {
      _solarContractSigned =
          prefs.getBool('ff_solarContractSigned') ?? _solarContractSigned;
    });
    _safeInit(() {
      _haveSupplyContract =
          prefs.getBool('ff_haveSupplyContract') ?? _haveSupplyContract;
    });
    _safeInit(() {
      _haveSolarContract =
          prefs.getBool('ff_haveSolarContract') ?? _haveSolarContract;
    });
    _safeInit(() {
      _monthlyCosts = prefs
              .getStringList('ff_monthlyCosts')
              ?.map((x) {
                try {
                  return MonthlyCostStruct.fromSerializableMap(jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _monthlyCosts;
    });
    _safeInit(() {
      if (prefs.containsKey('ff_tariffs')) {
        try {
          final serializedData = prefs.getString('ff_tariffs') ?? '{}';
          _tariffs =
              TariffsStruct.fromSerializableMap(jsonDecode(serializedData));
        } catch (e) {
          print("Can't decode persisted data type. Error: $e.");
        }
      }
    });
    _safeInit(() {
      _impersonationPhone =
          prefs.getString('ff_impersonationPhone') ?? _impersonationPhone;
    });
    _safeInit(() {
      if (prefs.containsKey('ff_solarInstallations')) {
        try {
          _solarInstallations =
              jsonDecode(prefs.getString('ff_solarInstallations') ?? '');
        } catch (e) {
          print("Can't decode persisted json. Error: $e.");
        }
      }
    });
    _safeInit(() {
      _lastMonthlyCostAndUsageLoad =
          prefs.containsKey('ff_lastMonthlyCostAndUsageLoad')
              ? DateTime.fromMillisecondsSinceEpoch(
                  prefs.getInt('ff_lastMonthlyCostAndUsageLoad')!)
              : _lastMonthlyCostAndUsageLoad;
    });
    _safeInit(() {
      if (prefs.containsKey('ff_supplyAccount')) {
        try {
          final serializedData = prefs.getString('ff_supplyAccount') ?? '{}';
          _supplyAccount =
              AccountStruct.fromSerializableMap(jsonDecode(serializedData));
        } catch (e) {
          print("Can't decode persisted data type. Error: $e.");
        }
      }
    });
    _safeInit(() {
      if (prefs.containsKey('ff_solarAccount')) {
        try {
          final serializedData = prefs.getString('ff_solarAccount') ?? '{}';
          _solarAccount =
              AccountStruct.fromSerializableMap(jsonDecode(serializedData));
        } catch (e) {
          print("Can't decode persisted data type. Error: $e.");
        }
      }
    });
    _safeInit(() {
      _accountsForCurrentProperty = prefs
              .getStringList('ff_accountsForCurrentProperty')
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
          _accountsForCurrentProperty;
    });
    _safeInit(() {
      _pendingPayments = prefs
              .getStringList('ff_pendingPayments')
              ?.map((x) {
                try {
                  return PaymentStruct.fromSerializableMap(jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _pendingPayments;
    });
    _safeInit(() {
      _lastPendingPaymentsLoad = prefs.containsKey('ff_lastPendingPaymentsLoad')
          ? DateTime.fromMillisecondsSinceEpoch(
              prefs.getInt('ff_lastPendingPaymentsLoad')!)
          : _lastPendingPaymentsLoad;
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

  List<AccountStruct> _accountsAll = [];
  List<AccountStruct> get accountsAll => _accountsAll;
  set accountsAll(List<AccountStruct> value) {
    _accountsAll = value;
    prefs.setStringList(
        'ff_accountsAll', value.map((x) => x.serialize()).toList());
  }

  void addToAccountsAll(AccountStruct value) {
    accountsAll.add(value);
    prefs.setStringList(
        'ff_accountsAll', _accountsAll.map((x) => x.serialize()).toList());
  }

  void removeFromAccountsAll(AccountStruct value) {
    accountsAll.remove(value);
    prefs.setStringList(
        'ff_accountsAll', _accountsAll.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromAccountsAll(int index) {
    accountsAll.removeAt(index);
    prefs.setStringList(
        'ff_accountsAll', _accountsAll.map((x) => x.serialize()).toList());
  }

  void updateAccountsAllAtIndex(
    int index,
    AccountStruct Function(AccountStruct) updateFn,
  ) {
    accountsAll[index] = updateFn(_accountsAll[index]);
    prefs.setStringList(
        'ff_accountsAll', _accountsAll.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInAccountsAll(int index, AccountStruct value) {
    accountsAll.insert(index, value);
    prefs.setStringList(
        'ff_accountsAll', _accountsAll.map((x) => x.serialize()).toList());
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
    prefs.setString('ff_property', value.serialize());
  }

  void updatePropertyStruct(Function(PropertyStruct) updateFn) {
    updateFn(_property);
    prefs.setString('ff_property', _property.serialize());
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

  String _impersonationToken = '';
  String get impersonationToken => _impersonationToken;
  set impersonationToken(String value) {
    _impersonationToken = value;
    prefs.setString('ff_impersonationToken', value);
  }

  String _impersonationEmail = '';
  String get impersonationEmail => _impersonationEmail;
  set impersonationEmail(String value) {
    _impersonationEmail = value;
    prefs.setString('ff_impersonationEmail', value);
  }

  CustomerStruct _customer = CustomerStruct();
  CustomerStruct get customer => _customer;
  set customer(CustomerStruct value) {
    _customer = value;
    prefs.setString('ff_customer', value.serialize());
  }

  void updateCustomerStruct(Function(CustomerStruct) updateFn) {
    updateFn(_customer);
    prefs.setString('ff_customer', _customer.serialize());
  }

  bool _solarContractSigned = false;
  bool get solarContractSigned => _solarContractSigned;
  set solarContractSigned(bool value) {
    _solarContractSigned = value;
    prefs.setBool('ff_solarContractSigned', value);
  }

  bool _haveSupplyContract = false;
  bool get haveSupplyContract => _haveSupplyContract;
  set haveSupplyContract(bool value) {
    _haveSupplyContract = value;
    prefs.setBool('ff_haveSupplyContract', value);
  }

  bool _haveSolarContract = false;
  bool get haveSolarContract => _haveSolarContract;
  set haveSolarContract(bool value) {
    _haveSolarContract = value;
    prefs.setBool('ff_haveSolarContract', value);
  }

  List<MonthlyCostStruct> _monthlyCosts = [];
  List<MonthlyCostStruct> get monthlyCosts => _monthlyCosts;
  set monthlyCosts(List<MonthlyCostStruct> value) {
    _monthlyCosts = value;
    prefs.setStringList(
        'ff_monthlyCosts', value.map((x) => x.serialize()).toList());
  }

  void addToMonthlyCosts(MonthlyCostStruct value) {
    monthlyCosts.add(value);
    prefs.setStringList(
        'ff_monthlyCosts', _monthlyCosts.map((x) => x.serialize()).toList());
  }

  void removeFromMonthlyCosts(MonthlyCostStruct value) {
    monthlyCosts.remove(value);
    prefs.setStringList(
        'ff_monthlyCosts', _monthlyCosts.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromMonthlyCosts(int index) {
    monthlyCosts.removeAt(index);
    prefs.setStringList(
        'ff_monthlyCosts', _monthlyCosts.map((x) => x.serialize()).toList());
  }

  void updateMonthlyCostsAtIndex(
    int index,
    MonthlyCostStruct Function(MonthlyCostStruct) updateFn,
  ) {
    monthlyCosts[index] = updateFn(_monthlyCosts[index]);
    prefs.setStringList(
        'ff_monthlyCosts', _monthlyCosts.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInMonthlyCosts(int index, MonthlyCostStruct value) {
    monthlyCosts.insert(index, value);
    prefs.setStringList(
        'ff_monthlyCosts', _monthlyCosts.map((x) => x.serialize()).toList());
  }

  TariffsStruct _tariffs = TariffsStruct();
  TariffsStruct get tariffs => _tariffs;
  set tariffs(TariffsStruct value) {
    _tariffs = value;
    prefs.setString('ff_tariffs', value.serialize());
  }

  void updateTariffsStruct(Function(TariffsStruct) updateFn) {
    updateFn(_tariffs);
    prefs.setString('ff_tariffs', _tariffs.serialize());
  }

  String _impersonationPhone = '';
  String get impersonationPhone => _impersonationPhone;
  set impersonationPhone(String value) {
    _impersonationPhone = value;
    prefs.setString('ff_impersonationPhone', value);
  }

  dynamic _solarInstallations;
  dynamic get solarInstallations => _solarInstallations;
  set solarInstallations(dynamic value) {
    _solarInstallations = value;
    prefs.setString('ff_solarInstallations', jsonEncode(value));
  }

  bool _monthlyCostsLoading = false;
  bool get monthlyCostsLoading => _monthlyCostsLoading;
  set monthlyCostsLoading(bool value) {
    _monthlyCostsLoading = value;
  }

  bool _monthlyUsageLoading = false;
  bool get monthlyUsageLoading => _monthlyUsageLoading;
  set monthlyUsageLoading(bool value) {
    _monthlyUsageLoading = value;
  }

  DateTime? _lastMonthlyCostAndUsageLoad =
      DateTime.fromMillisecondsSinceEpoch(946648800000);
  DateTime? get lastMonthlyCostAndUsageLoad => _lastMonthlyCostAndUsageLoad;
  set lastMonthlyCostAndUsageLoad(DateTime? value) {
    _lastMonthlyCostAndUsageLoad = value;
    value != null
        ? prefs.setInt(
            'ff_lastMonthlyCostAndUsageLoad', value.millisecondsSinceEpoch)
        : prefs.remove('ff_lastMonthlyCostAndUsageLoad');
  }

  AccountStruct _supplyAccount = AccountStruct();
  AccountStruct get supplyAccount => _supplyAccount;
  set supplyAccount(AccountStruct value) {
    _supplyAccount = value;
    prefs.setString('ff_supplyAccount', value.serialize());
  }

  void updateSupplyAccountStruct(Function(AccountStruct) updateFn) {
    updateFn(_supplyAccount);
    prefs.setString('ff_supplyAccount', _supplyAccount.serialize());
  }

  AccountStruct _solarAccount = AccountStruct();
  AccountStruct get solarAccount => _solarAccount;
  set solarAccount(AccountStruct value) {
    _solarAccount = value;
    prefs.setString('ff_solarAccount', value.serialize());
  }

  void updateSolarAccountStruct(Function(AccountStruct) updateFn) {
    updateFn(_solarAccount);
    prefs.setString('ff_solarAccount', _solarAccount.serialize());
  }

  /// accounts for a single property
  List<AccountStruct> _accountsForCurrentProperty = [];
  List<AccountStruct> get accountsForCurrentProperty =>
      _accountsForCurrentProperty;
  set accountsForCurrentProperty(List<AccountStruct> value) {
    _accountsForCurrentProperty = value;
    prefs.setStringList('ff_accountsForCurrentProperty',
        value.map((x) => x.serialize()).toList());
  }

  void addToAccountsForCurrentProperty(AccountStruct value) {
    accountsForCurrentProperty.add(value);
    prefs.setStringList('ff_accountsForCurrentProperty',
        _accountsForCurrentProperty.map((x) => x.serialize()).toList());
  }

  void removeFromAccountsForCurrentProperty(AccountStruct value) {
    accountsForCurrentProperty.remove(value);
    prefs.setStringList('ff_accountsForCurrentProperty',
        _accountsForCurrentProperty.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromAccountsForCurrentProperty(int index) {
    accountsForCurrentProperty.removeAt(index);
    prefs.setStringList('ff_accountsForCurrentProperty',
        _accountsForCurrentProperty.map((x) => x.serialize()).toList());
  }

  void updateAccountsForCurrentPropertyAtIndex(
    int index,
    AccountStruct Function(AccountStruct) updateFn,
  ) {
    accountsForCurrentProperty[index] =
        updateFn(_accountsForCurrentProperty[index]);
    prefs.setStringList('ff_accountsForCurrentProperty',
        _accountsForCurrentProperty.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInAccountsForCurrentProperty(
      int index, AccountStruct value) {
    accountsForCurrentProperty.insert(index, value);
    prefs.setStringList('ff_accountsForCurrentProperty',
        _accountsForCurrentProperty.map((x) => x.serialize()).toList());
  }

  /// For notification on the home screen
  List<PaymentStruct> _pendingPayments = [];
  List<PaymentStruct> get pendingPayments => _pendingPayments;
  set pendingPayments(List<PaymentStruct> value) {
    _pendingPayments = value;
    prefs.setStringList(
        'ff_pendingPayments', value.map((x) => x.serialize()).toList());
  }

  void addToPendingPayments(PaymentStruct value) {
    pendingPayments.add(value);
    prefs.setStringList('ff_pendingPayments',
        _pendingPayments.map((x) => x.serialize()).toList());
  }

  void removeFromPendingPayments(PaymentStruct value) {
    pendingPayments.remove(value);
    prefs.setStringList('ff_pendingPayments',
        _pendingPayments.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromPendingPayments(int index) {
    pendingPayments.removeAt(index);
    prefs.setStringList('ff_pendingPayments',
        _pendingPayments.map((x) => x.serialize()).toList());
  }

  void updatePendingPaymentsAtIndex(
    int index,
    PaymentStruct Function(PaymentStruct) updateFn,
  ) {
    pendingPayments[index] = updateFn(_pendingPayments[index]);
    prefs.setStringList('ff_pendingPayments',
        _pendingPayments.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInPendingPayments(int index, PaymentStruct value) {
    pendingPayments.insert(index, value);
    prefs.setStringList('ff_pendingPayments',
        _pendingPayments.map((x) => x.serialize()).toList());
  }

  DateTime? _lastPendingPaymentsLoad =
      DateTime.fromMillisecondsSinceEpoch(946648800000);
  DateTime? get lastPendingPaymentsLoad => _lastPendingPaymentsLoad;
  set lastPendingPaymentsLoad(DateTime? value) {
    _lastPendingPaymentsLoad = value;
    value != null
        ? prefs.setInt(
            'ff_lastPendingPaymentsLoad', value.millisecondsSinceEpoch)
        : prefs.remove('ff_lastPendingPaymentsLoad');
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}