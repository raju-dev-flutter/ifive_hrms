import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/core.dart';
import '../../../account.dart';

class ProfileContactStream {
  ProfileContactStream(
      {required CountryUseCase $CountryUseCase,
      required StateUseCase $StateUseCase,
      required CityUseCase $CityUseCase})
      : _$CountryUseCase = $CountryUseCase,
        _$StateUseCase = $StateUseCase,
        _$CityUseCase = $CityUseCase;

  final CountryUseCase _$CountryUseCase;
  final StateUseCase _$StateUseCase;
  final CityUseCase _$CityUseCase;

  final _isLoading = BehaviorSubject<bool>.seeded(false);

  late TextEditingController permanentStreet = TextEditingController();
  late TextEditingController permanentAddress = TextEditingController();
  late TextEditingController permanentFlatNo = TextEditingController();
  late TextEditingController permanentLocality = TextEditingController();
  late TextEditingController permanentPinCode = TextEditingController();

  final _permanentCountry = BehaviorSubject<List<CommonList>>.seeded([]);
  final _permanentCountryListInit = BehaviorSubject<CommonList>();

  final _permanentState = BehaviorSubject<List<CommonList>>.seeded([]);
  final _permanentStateListInit = BehaviorSubject<CommonList>();

  final _permanentCity = BehaviorSubject<List<CommonList>>.seeded([]);
  final _permanentCityListInit = BehaviorSubject<CommonList>();

  final _sameAddress = BehaviorSubject<bool>.seeded(false);

  late TextEditingController currentStreet = TextEditingController();
  late TextEditingController currentAddress = TextEditingController();
  late TextEditingController currentFlatNo = TextEditingController();
  late TextEditingController currentLocality = TextEditingController();
  late TextEditingController currentPinCode = TextEditingController();

  final _currentCountry = BehaviorSubject<List<CommonList>>.seeded([]);
  final _currentCountryListInit = BehaviorSubject<CommonList>();

  final _currentState = BehaviorSubject<List<CommonList>>.seeded([]);
  final _currentStateListInit = BehaviorSubject<CommonList>();

  final _currentCity = BehaviorSubject<List<CommonList>>.seeded([]);
  final _currentCityListInit = BehaviorSubject<CommonList>();

  ValueStream<bool> get isLoading => _isLoading.stream;

  Stream<List<CommonList>> get permanentCountry => _permanentCountry.stream;
  Stream<List<CommonList>> get permanentState => _permanentState.stream;
  Stream<List<CommonList>> get permanentCity => _permanentCity.stream;

  ValueStream<CommonList> get permanentCountryListInit =>
      _permanentCountryListInit.stream;
  ValueStream<CommonList> get permanentStateListInit =>
      _permanentStateListInit.stream;
  ValueStream<CommonList> get permanentCityListInit =>
      _permanentCityListInit.stream;

  Stream<List<CommonList>> get currentCountry => _currentCountry.stream;
  Stream<List<CommonList>> get currentState => _currentState.stream;
  Stream<List<CommonList>> get currentCity => _currentCity.stream;

  Stream<bool> get sameAddress => _sameAddress.stream;

  ValueStream<CommonList> get currentCountryListInit =>
      _currentCountryListInit.stream;
  ValueStream<CommonList> get currentStateListInit =>
      _currentStateListInit.stream;
  ValueStream<CommonList> get currentCityListInit =>
      _currentCityListInit.stream;

  Future<void> fetchInitialCallBack() async {
    final countryResponse = await _$CountryUseCase();
    countryResponse.fold(
      (_) => {_permanentCountry.add([]), _currentCountry.add([])},
      (_) {
        if (_.country!.isNotEmpty) {
          _permanentCountry.add(_.country ?? []);
          _currentCountry.add(_.country ?? []);
        }
      },
    );
  }

  void fetchInitialCallBackWithDetail(Contact? contact) async {
    _isLoading.sink.add(true);

    permanentStreet =
        TextEditingController(text: contact?.permanentStreet ?? '');
    permanentAddress =
        TextEditingController(text: contact?.permanentStreetAddress ?? '');
    permanentFlatNo =
        TextEditingController(text: contact?.permanentFlatNo ?? '');
    permanentLocality =
        TextEditingController(text: contact?.permanentLocality ?? '');
    permanentPinCode = TextEditingController(
        text: (contact!.permanentPostalCode ?? '').toString());

    final permanentCountryResponse = await _$CountryUseCase();
    permanentCountryResponse.fold(
      (_) => {_permanentCountry.add([])},
      (_) {
        if (_.country!.isNotEmpty) {
          _permanentCountry.sink.add(_.country ?? []);
          for (var country in _.country!) {
            if (country.id == int.parse(contact.permanentCountry ?? '')) {
              _permanentCountryListInit.sink.add(country);
              break;
            }
          }
        }
      },
    );

    final permanentStateResponse =
        await _$StateUseCase(contact.permanentCountry ?? '');
    permanentStateResponse.fold(
      (_) => {_permanentState.add([])},
      (_) {
        if (_.state!.isNotEmpty) {
          for (var state in _.state!) {
            _permanentState.sink.add(_.state ?? []);
            if (state.id == int.parse(contact.permanentState ?? '')) {
              _permanentStateListInit.sink.add(state);
              break;
            }
          }
        }
      },
    );

    final permanentCityResponse =
        await _$CityUseCase(contact.permanentState ?? '');
    permanentCityResponse.fold(
      (_) => {_permanentCity.add([])},
      (_) {
        if (_.city!.isNotEmpty) {
          for (var city in _.city!) {
            _permanentCity.sink.add(_.city ?? []);
            if (city.id == int.parse(contact.permanentCity ?? '')) {
              _permanentCityListInit.sink.add(city);
              break;
            }
          }
        }
      },
    );

    _sameAddress.sink.add(contact.sameAddress == "on" ? true : false);

    currentStreet = TextEditingController(text: contact.currentStreet ?? '');
    currentAddress =
        TextEditingController(text: contact.currentStreetAddress ?? '');
    currentFlatNo = TextEditingController(text: contact.currentFlatNo ?? '');
    currentLocality =
        TextEditingController(text: contact.currentLocality ?? '');
    currentPinCode = TextEditingController(
        text: (contact.currentPostalCode ?? '').toString());

    final currentCountryResponse = await _$CountryUseCase();
    currentCountryResponse.fold(
      (_) => {_currentCountry.add([])},
      (_) {
        if (_.country!.isNotEmpty) {
          for (var country in _.country!) {
            _currentCountry.sink.add(_.country ?? []);
            if (country.id == int.parse(contact.currentCountry ?? '')) {
              _currentCountryListInit.sink.add(country);
              break;
            }
          }
        }
      },
    );

    final currentStateResponse =
        await _$StateUseCase(contact.currentCountry ?? '');
    currentStateResponse.fold(
      (_) => {_currentState.add([])},
      (_) {
        if (_.state!.isNotEmpty) {
          for (var state in _.state!) {
            _currentState.sink.add(_.state ?? []);
            if (state.id == int.parse(contact.currentState ?? '')) {
              _currentStateListInit.sink.add(state);
              break;
            }
          }
        }
      },
    );

    final currentCityResponse = await _$CityUseCase(contact.currentState ?? '');
    currentCityResponse.fold(
      (_) => {_currentCity.add([])},
      (_) {
        if (_.city!.isNotEmpty) {
          for (var city in _.city!) {
            _currentCity.sink.add(_.city ?? []);
            if (city.id == int.parse(contact.currentCity ?? '')) {
              _currentCityListInit.sink.add(city);
              break;
            }
          }
        }
      },
    );

    _isLoading.sink.add(false);
  }

  void selectedPermanentCountry(val) {
    _permanentCountryListInit.sink
        .add(CommonList(id: val.value, name: val.name));
    permanentCountryBasedState(_permanentCountryListInit.valueOrNull!.id ?? 0);
  }

  void permanentCountryBasedState(cityId) async {
    final stateResponse = await _$StateUseCase(cityId.toString());
    stateResponse.fold(
      (_) => {_permanentState.add([])},
      (_) {
        if (_.state!.isNotEmpty) {
          _permanentState.add(_.state ?? []);
        }
      },
    );
  }

  void selectedPermanentState(val) {
    _permanentStateListInit.sink.add(CommonList(id: val.value, name: val.name));
    permanentStateBasedCity(_permanentStateListInit.valueOrNull!.id ?? 0);
  }

  void permanentStateBasedCity(stateId) async {
    final cityResponse = await _$CityUseCase(stateId.toString());
    cityResponse.fold(
      (_) => {_permanentCity.add([])},
      (_) {
        if (_.city!.isNotEmpty) {
          _permanentCity.add(_.city ?? []);
        }
      },
    );
  }

  void selectedPermanentCity(val) {
    _permanentCityListInit.sink.add(CommonList(id: val.value, name: val.name));
  }

  void selectedCurrentCountry(val) {
    _currentCountryListInit.sink.add(CommonList(id: val.value, name: val.name));
    currentCountryBasedState(_currentCountryListInit.valueOrNull!.id ?? 0);
  }

  void currentCountryBasedState(countryId) async {
    final stateResponse = await _$StateUseCase(countryId.toString());
    stateResponse.fold(
      (_) => {_currentState.add([])},
      (_) => {if (_.state!.isNotEmpty) _currentState.add(_.state ?? [])},
    );
  }

  void selectedCurrentState(val) {
    _currentStateListInit.sink.add(CommonList(id: val.value, name: val.name));
    currentStateBasedCity(_currentStateListInit.valueOrNull!.id ?? 0);
  }

  void currentStateBasedCity(stateId) async {
    final cityResponse = await _$CityUseCase(stateId.toString());
    cityResponse.fold(
      (_) => {_currentCity.add([])},
      (_) => {if (_.city!.isNotEmpty) _currentCity.add(_.city ?? [])},
    );
  }

  void selectedCurrentCity(val) {
    _currentCityListInit.sink.add(CommonList(id: val.value, name: val.name));
  }

  void isSameAddress(bool val) => _sameAddress.sink.add(val);

  void onSubmit(BuildContext context,
      List<Map<String, TextEditingController>> multiController) {
    List<Map<String, String>> emergencyContacts = [];

    for (var controller in multiController) {
      Map<String, String> contacts = {
        'emergency_name': controller['emergency_name']!.text,
        'emergency_relation_type': controller['emergency_relation_type']!.text,
        'emergency_address': controller['emergency_address']!.text,
        'emergency_contact_number':
            controller['emergency_contact_number']!.text,
      };
      emergencyContacts.add(contacts);
    }

    final isSame = _sameAddress.valueOrNull == true ? true : false;

    final body = {
      "permanent_street": permanentStreet.text,
      "permanent_flat_no": permanentFlatNo.text,
      "permanent_address": permanentAddress.text,
      "permanent_country": _permanentCountryListInit.valueOrNull!.id ?? 0,
      "permanent_state": _permanentStateListInit.valueOrNull!.id ?? 0,
      "permanent_city": _permanentCityListInit.valueOrNull!.id ?? 0,
      "permanent_pincode": permanentLocality.text,
      "permanent_locality": permanentLocality.text,
      "same_address": _sameAddress.valueOrNull ?? false,
      "current_street": isSame ? permanentStreet.text : currentStreet.text,
      "current_flat_no": isSame ? permanentFlatNo.text : currentFlatNo.text,
      "current_address": isSame ? permanentAddress.text : currentAddress.text,
      "current_country": isSame
          ? _permanentCountryListInit.valueOrNull!.id ?? 0
          : _currentCountryListInit.valueOrNull!.id ?? 0,
      "current_state": isSame
          ? _permanentStateListInit.valueOrNull!.id ?? 0
          : _permanentStateListInit.valueOrNull!.id ?? 0,
      "current_city": isSame
          ? _permanentCityListInit.valueOrNull!.id ?? 0
          : _currentCityListInit.valueOrNull!.id ?? 0,
      "current_pincode": isSame ? permanentLocality.text : currentPinCode.text,
      "current_locality":
          isSame ? permanentLocality.text : currentLocality.text,
      "emergency_contacts": emergencyContacts,
    };
    Logger().d("Submit: $body");

    BlocProvider.of<AccountCrudBloc>(context).add(ContactEvent(body: body));
  }

  void onUpdate(BuildContext context, Contact contact,
      List<Map<String, TextEditingController>> multiController) {
    List<Map<String, String>> emergencyContacts = [];

    for (var controller in multiController) {
      Map<String, String> contacts = {
        'emergency_name': controller['emergency_name']!.text,
        'emergency_relation_type': controller['emergency_relation_type']!.text,
        'emergency_address': controller['emergency_address']!.text,
        'emergency_contact_number':
            controller['emergency_contact_number']!.text,
      };
      emergencyContacts.add(contacts);
    }

    final isSame = _sameAddress.valueOrNull == true ? true : false;

    final body = {
      "contact_id": contact.id,
      "permanent_street": permanentStreet.text,
      "permanent_flat_no": permanentFlatNo.text,
      "permanent_address": permanentAddress.text,
      "permanent_country": _permanentCountryListInit.valueOrNull!.id ?? 0,
      "permanent_state": _permanentStateListInit.valueOrNull!.id ?? 0,
      "permanent_city": _permanentCityListInit.valueOrNull!.id ?? 0,
      "permanent_pincode": permanentPinCode.text,
      "permanent_locality": permanentLocality.text,
      "same_address": _sameAddress.valueOrNull ?? false,
      "current_street": isSame ? permanentStreet.text : currentStreet.text,
      "current_flat_no": isSame ? permanentFlatNo.text : currentFlatNo.text,
      "current_address": isSame ? permanentAddress.text : currentAddress.text,
      "current_country": isSame
          ? _permanentCountryListInit.valueOrNull!.id ?? 0
          : _currentCountryListInit.valueOrNull!.id ?? 0,
      "current_state": isSame
          ? _permanentStateListInit.valueOrNull!.id ?? 0
          : _permanentStateListInit.valueOrNull!.id ?? 0,
      "current_city": isSame
          ? _permanentCityListInit.valueOrNull!.id ?? 0
          : _currentCityListInit.valueOrNull!.id ?? 0,
      "current_pincode": isSame ? permanentPinCode.text : currentPinCode.text,
      "current_locality":
          isSame ? permanentLocality.text : currentLocality.text,
      "emergency_contacts": emergencyContacts,
    };
    Logger().d("Submit: $body");

    BlocProvider.of<AccountCrudBloc>(context).add(ContactEvent(body: body));
  }

  void onClose() {
    permanentStreet.clear();
    permanentFlatNo.clear();
    permanentAddress.clear();
    _permanentCountryListInit.add(CommonList());
    _permanentStateListInit.add(CommonList());
    _permanentCityListInit.add(CommonList());
    permanentPinCode.clear();
    permanentLocality.clear();

    currentStreet.clear();
    currentFlatNo.clear();
    currentAddress.clear();
    _currentCountryListInit.add(CommonList());
    _permanentStateListInit.add(CommonList());
    _currentCityListInit.add(CommonList());
    currentPinCode.clear();
    currentLocality.clear();
  }
}
