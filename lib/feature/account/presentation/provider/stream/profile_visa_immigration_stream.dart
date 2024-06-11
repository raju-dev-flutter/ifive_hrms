import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifive_hrms/feature/account/account.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/core.dart';

class ProfileVisaImmigrationStream {
  ProfileVisaImmigrationStream({required CountryUseCase $CountryUseCase})
      : _$CountryUseCase = $CountryUseCase;

  final CountryUseCase _$CountryUseCase;

  final _isLoading = BehaviorSubject<bool>.seeded(false);

  late TextEditingController passportNumber = TextEditingController();
  late TextEditingController visaTypeCode = TextEditingController();
  late TextEditingController visaNumber = TextEditingController();

  final _passportIssuedDate = BehaviorSubject<DateTime?>();
  final _passportExpiryDate = BehaviorSubject<DateTime?>();
  final _visaIssuedDate = BehaviorSubject<DateTime?>();
  final _visaExpiryDate = BehaviorSubject<DateTime?>();

  final _selectPassportIssuedDate = BehaviorSubject<String>();
  final _selectPassportExpiryDate = BehaviorSubject<String>();
  final _selectVisaIssuedDate = BehaviorSubject<String>();
  final _selectVisaExpiryDate = BehaviorSubject<String>();

  final _visaCountry = BehaviorSubject<List<CommonList>>.seeded([]);
  final _visaCountryListInit = BehaviorSubject<CommonList>();

  final _file = BehaviorSubject<File?>();

  ValueStream<bool> get isLoading => _isLoading.stream;

  ValueStream<DateTime?> get passportIssuedDate => _passportIssuedDate.stream;
  ValueStream<DateTime?> get passportExpiryDate => _passportExpiryDate.stream;
  ValueStream<DateTime?> get visaIssuedDate => _visaIssuedDate.stream;
  ValueStream<DateTime?> get visaExpiryDate => _visaExpiryDate.stream;

  ValueStream<String> get selectPassportIssuedDate =>
      _selectPassportIssuedDate.stream;
  ValueStream<String> get selectPassportExpiryDate =>
      _selectPassportExpiryDate.stream;
  ValueStream<String> get selectVisaIssuedDate => _selectVisaIssuedDate.stream;
  ValueStream<String> get selectVisaExpiryDate => _selectVisaExpiryDate.stream;

  Stream<List<CommonList>> get visaCountry => _visaCountry.stream;

  ValueStream<CommonList> get visaCountryListInit =>
      _visaCountryListInit.stream;

  ValueStream<File?> get file => _file.stream;

  Future<void> fetchInitialCallBack() async {
    final countryResponse = await _$CountryUseCase();
    countryResponse.fold(
      (_) => {_visaCountry.add([])},
      (_) {
        if (_.country!.isNotEmpty) {
          _visaCountry.add(_.country ?? []);
        }
      },
    );
  }

  void fetchInitialCallBackWithDetail(VisaImmigration? vi) async {
    _isLoading.sink.add(true);

    passportNumber = TextEditingController(text: vi!.passportNumber ?? '');
    visaTypeCode = TextEditingController(text: vi.visaTypeCode ?? '');
    visaNumber = TextEditingController(text: vi.visaNumber ?? '');

    _selectPassportIssuedDate.sink.add(vi.passportIssuedDate ?? '');
    _selectPassportExpiryDate.sink.add(vi.passportExpiryDate ?? '');
    _selectVisaIssuedDate.sink.add(vi.visaIssuedDate ?? '');
    _selectVisaExpiryDate.sink.add(vi.visaExpiryDate ?? '');

    final countryResponse = await _$CountryUseCase();
    countryResponse.fold(
      (_) => {_visaCountry.add([])},
      (_) {
        if (_.country!.isNotEmpty) {
          _visaCountry.add(_.country ?? []);
          for (var country in _.country ?? []) {
            if (country.id == int.parse(vi.visaCountry ?? '0')) {
              _visaCountryListInit.sink.add(country);
              break;
            }
          }
        }
      },
    );
    _isLoading.sink.add(false);
  }

  void selectedPassportIssuedDate(DateTime date) {
    _passportIssuedDate.sink.add(date);
    _selectPassportIssuedDate.sink.add(DateFormat('yyyy-MM-dd').format(date));
  }

  void selectedPassportExpiryDate(DateTime date) {
    _passportExpiryDate.sink.add(date);
    _selectPassportExpiryDate.sink.add(DateFormat('yyyy-MM-dd').format(date));
  }

  void selectedVisaIssuedDate(DateTime date) {
    _visaIssuedDate.sink.add(date);
    _selectVisaIssuedDate.sink.add(DateFormat('yyyy-MM-dd').format(date));
  }

  void selectedVisaExpiryDate(DateTime date) {
    _visaExpiryDate.sink.add(date);
    _selectVisaExpiryDate.sink.add(DateFormat('yyyy-MM-dd').format(date));
  }

  void selectedVisaCountry(val) {
    _visaCountryListInit.sink.add(CommonList(id: val.value, name: val.name));
  }

  void selectedFile() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickMedia();
    if (pickedFile != null) _file.sink.add(File(pickedFile.path));
  }

  void removeFile() async => _file.sink.add(null);

  void onSubmit(BuildContext context) {
    final body = {
      "passport_number": passportNumber.text,
      "passport_issued_date": _selectPassportIssuedDate.valueOrNull ?? '',
      "passport_expiry_date": _selectPassportExpiryDate.valueOrNull ?? '',
      "visa_number": visaNumber.text,
      "visa_issued_date": _selectVisaIssuedDate.valueOrNull ?? '',
      "visa_expiry_date": _selectVisaIssuedDate.valueOrNull ?? '',
      "visa_type_code": visaTypeCode.text,
      "visa_country": _visaCountryListInit.valueOrNull!.id ?? 0,
    };
    Logger().d("Submit: $body");

    final file = _file.valueOrNull;
    BlocProvider.of<AccountCrudBloc>(context)
        .add(VisaAndImmigrationEvent(body: body, files: file));
  }

  void onUpdate(BuildContext context, VisaImmigration vi) {
    final body = {
      "visa_id": vi.id,
      "passport_number": passportNumber.text,
      "passport_issued_date": _selectPassportIssuedDate.valueOrNull ?? '',
      "passport_expiry_date": _selectPassportExpiryDate.valueOrNull ?? '',
      "visa_number": visaNumber.text,
      "visa_issued_date": _selectVisaIssuedDate.valueOrNull ?? '',
      "visa_expiry_date": _selectVisaIssuedDate.valueOrNull ?? '',
      "visa_type_code": visaTypeCode.text,
      "visa_country": _visaCountryListInit.valueOrNull!.id ?? 0,
    };
    Logger().d("Submit: $body");

    final file = _file.valueOrNull;
    BlocProvider.of<AccountCrudBloc>(context)
        .add(VisaAndImmigrationEvent(body: body, files: file));
  }

  void onDelete(BuildContext context, VisaImmigration vi) async {
    final body = {"visa_id": vi.id, "visa_status": 'delete'};
    Logger().d("Submit: $body");

    final file = _file.valueOrNull;
    BlocProvider.of<AccountCrudBloc>(context)
        .add(VisaAndImmigrationEvent(body: body, files: file));
  }

  void onClose() {
    passportNumber.clear();
    visaTypeCode.clear();
    visaNumber.clear();

    _selectPassportIssuedDate.sink.add('');
    _selectPassportExpiryDate.sink.add('');
    _selectVisaIssuedDate.sink.add('');
    _selectVisaExpiryDate.sink.add('');

    _visaCountryListInit.sink.add(CommonList());
  }
}
