import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/core.dart';
import '../../../account.dart';

class ProfilePersonalStream {
  ProfilePersonalStream(
      {required NationalityUseCase $NationalityUseCase,
      required MotherTongueUseCase $MotherTongueUseCase,
      required BloodGroupUseCase $BloodGroupUseCase})
      : _$NationalityUseCase = $NationalityUseCase,
        _$MotherTongueUseCase = $MotherTongueUseCase,
        _$BloodGroupUseCase = $BloodGroupUseCase;

  final NationalityUseCase _$NationalityUseCase;
  final MotherTongueUseCase _$MotherTongueUseCase;
  final BloodGroupUseCase _$BloodGroupUseCase;

  late TextEditingController personalMail = TextEditingController();
  late TextEditingController personalContact = TextEditingController();

  final _isLoading = BehaviorSubject<bool>.seeded(false);

  final _gender = BehaviorSubject<List<CommonList>>.seeded([]);
  final _genderListInit = BehaviorSubject<CommonList>();

  final _maritalStatus = BehaviorSubject<List<CommonList>>.seeded([]);
  final _maritalStatusListInit = BehaviorSubject<CommonList>();

  final _nationality = BehaviorSubject<List<CommonList>>.seeded([]);
  final _nationalityListInit = BehaviorSubject<CommonList>();

  final _bloodGroup = BehaviorSubject<List<CommonList>>.seeded([]);
  final _bloodGroupListInit = BehaviorSubject<CommonList>();

  final _motherTongue = BehaviorSubject<List<CommonList>>.seeded([]);
  final _motherTongueListInit = BehaviorSubject<CommonList>();

  final _dob = BehaviorSubject<DateTime?>();
  final _selectDob = BehaviorSubject<String>();

  final _age = BehaviorSubject<String>();

  late TextEditingController fatherName = TextEditingController();
  late TextEditingController fatherAadhaarNumber = TextEditingController();

  ValueStream<bool> get isLoading => _isLoading.stream;

  final _fatherDob = BehaviorSubject<DateTime?>();
  final _selectFatherDob = BehaviorSubject<String>();

  final _fatherAge = BehaviorSubject<String>();

  late TextEditingController motherName = TextEditingController();
  late TextEditingController motherAadhaarNumber = TextEditingController();

  final _motherDob = BehaviorSubject<DateTime?>();
  final _selectMotherDob = BehaviorSubject<String>();

  final _motherAge = BehaviorSubject<String>();

  Stream<List<CommonList>> get gender => _gender.stream;

  Stream<List<CommonList>> get maritalStatus => _maritalStatus.stream;

  Stream<List<CommonList>> get nationality => _nationality.stream;

  Stream<List<CommonList>> get bloodGroup => _bloodGroup.stream;

  Stream<List<CommonList>> get motherTongue => _motherTongue.stream;

  ValueStream<CommonList> get genderListInit => _genderListInit.stream;

  ValueStream<CommonList> get maritalStatusListInit =>
      _maritalStatusListInit.stream;

  ValueStream<CommonList> get nationalityListInit =>
      _nationalityListInit.stream;

  ValueStream<CommonList> get bloodGroupListInit => _bloodGroupListInit.stream;

  ValueStream<CommonList> get motherTongueListInit =>
      _motherTongueListInit.stream;

  ValueStream<DateTime?> get dob => _dob.stream;

  ValueStream<DateTime?> get fatherDob => _fatherDob.stream;

  ValueStream<DateTime?> get motherDob => _motherDob.stream;

  ValueStream<String> get selectDob => _selectDob.stream;

  ValueStream<String> get selectFatherDob => _selectFatherDob.stream;

  ValueStream<String> get selectMotherDob => _selectMotherDob.stream;

  ValueStream<String> get age => _age.stream;
  ValueStream<String> get fatherAge => _fatherAge.stream;
  ValueStream<String> get motherAge => _motherAge.stream;

  Future<void> fetchInitialCallBack() async {
    _gender.sink.add(
        [CommonList(id: 1, name: "Male"), CommonList(id: 2, name: "Female")]);

    _maritalStatus.sink.add([
      CommonList(id: 1, name: "Single"),
      CommonList(id: 2, name: "Married")
    ]);

    final nationalityResponse = await _$NationalityUseCase();
    nationalityResponse.fold(
      (_) => {_nationality.add([])},
      (_) => {
        if (_.nationality!.isNotEmpty) _nationality.add(_.nationality ?? [])
      },
    );

    final motherTongueResponse = await _$MotherTongueUseCase();
    motherTongueResponse.fold(
      (_) => {_nationality.add([])},
      (_) => {
        if (_.motherTongue!.isNotEmpty) _motherTongue.add(_.motherTongue ?? [])
      },
    );

    final bloodGroupResponse = await _$BloodGroupUseCase();
    bloodGroupResponse.fold(
      (_) => {_bloodGroup.add([])},
      (_) =>
          {if (_.bloodGroup!.isNotEmpty) _bloodGroup.add(_.bloodGroup ?? [])},
    );
  }

  void fetchInitialCallBackWithDetail(Personal? personal) async {
    _isLoading.sink.add(true);

    _gender.sink.add(
        [CommonList(id: 1, name: "Male"), CommonList(id: 2, name: "Female")]);

    for (var gender in _gender.valueOrNull ?? []) {
      if (gender.id == int.parse(personal?.gender ?? '0')) {
        _genderListInit.sink.add(gender);
      }
    }

    _maritalStatus.sink.add([
      CommonList(id: 1, name: "Single"),
      CommonList(id: 2, name: "Married")
    ]);

    for (var marital in _maritalStatus.valueOrNull ?? []) {
      if (marital.id == int.parse(personal?.maritalStatus ?? '0')) {
        _maritalStatusListInit.sink.add(marital);
      }
    }

    final nationalityResponse = await _$NationalityUseCase();
    nationalityResponse.fold(
      (_) => {_nationality.add([])},
      (_) {
        if (_.nationality!.isNotEmpty) {
          _nationality.add(_.nationality ?? []);
          for (var nationality in _nationality.valueOrNull ?? []) {
            if (nationality.id == int.parse(personal?.nationality ?? '0')) {
              _nationalityListInit.sink.add(nationality);
              break;
            }
          }
        }
      },
    );

    final motherTongueResponse = await _$MotherTongueUseCase();
    motherTongueResponse.fold(
      (_) => {_motherTongue.add([])},
      (_) {
        if (_.motherTongue!.isNotEmpty) {
          _motherTongue.add(_.motherTongue ?? []);
          for (var motherTongue in _.motherTongue ?? []) {
            if (motherTongue.id == (personal?.motherTongue ?? 0)) {
              _motherTongueListInit.sink.add(motherTongue);
              break;
            }
          }
        }
      },
    );

    final bloodGroupResponse = await _$BloodGroupUseCase();
    bloodGroupResponse.fold(
      (_) => {_bloodGroup.add([])},
      (_) {
        if (_.bloodGroup!.isNotEmpty) {
          _bloodGroup.add(_.bloodGroup ?? []);
          for (var bloodGroup in _.bloodGroup ?? []) {
            if (bloodGroup.id == int.parse(personal?.bloodGroup ?? '0')) {
              _bloodGroupListInit.sink.add(bloodGroup);
              break;
            }
          }
        }
      },
    );

    personalMail = TextEditingController(text: personal?.personalMail ?? '');
    personalContact =
        TextEditingController(text: personal?.personalMobile ?? '');

    fatherName = TextEditingController(text: personal?.fatherName ?? '');
    fatherAadhaarNumber =
        TextEditingController(text: personal?.fatherAadharNumber ?? '');

    motherName = TextEditingController(text: personal?.motherName ?? '');
    motherAadhaarNumber =
        TextEditingController(text: personal?.motherAadharNumber ?? '');

    _selectDob.sink.add(personal?.dateOfBirth ?? '');
    _age.sink.add((personal?.age ?? '').toString());
    _selectFatherDob.sink.add(personal?.fatherDob ?? '');
    _fatherAge.sink.add((personal?.fatherAge ?? '').toString());
    _selectMotherDob.sink.add(personal?.motherDob ?? '');
    _age.sink.add((personal?.motherAge ?? '').toString());

    _isLoading.sink.add(false);
  }

  void selectedGender(val) {
    _genderListInit.sink.add(CommonList(id: val.value, name: val.name));
  }

  void selectedMaritalStatus(val) {
    _maritalStatusListInit.sink.add(CommonList(id: val.value, name: val.name));
  }

  void selectedBloodGroupListInit(val) {
    _nationalityListInit.sink.add(CommonList(id: val.value, name: val.name));
  }

  void selectedNationality(val) {
    _nationalityListInit.sink.add(CommonList(id: val.value, name: val.name));
  }

  void selectedBloodGroup(val) {
    _bloodGroupListInit.sink.add(CommonList(id: val.value, name: val.name));
  }

  void selectedMotherTongue(val) {
    _motherTongueListInit.sink.add(CommonList(id: val.value, name: val.name));
  }

  void selectedDob(DateTime date) {
    _dob.sink.add(date);
    _selectDob.sink.add(DateFormat('yyyy-MM-dd').format(date));
    final age = PickDateTime.calculateAge(date);
    _age.sink.add(age);
  }

  void selectedFatherDob(DateTime date) {
    _fatherDob.sink.add(date);
    _selectFatherDob.sink.add(DateFormat('yyyy-MM-dd').format(date));
    final age = PickDateTime.calculateAge(date);
    _fatherAge.sink.add(age);
  }

  void selectedMotherDob(DateTime date) {
    _motherDob.sink.add(date);
    _selectMotherDob.sink.add(DateFormat('yyyy-MM-dd').format(date));
    final age = PickDateTime.calculateAge(date);
    _motherAge.sink.add(age);
  }

  void onSubmit(BuildContext context,
      List<Map<String, TextEditingController>> multiController) {
    List<Map<String, String>> languageList = [];

    for (var controller in multiController) {
      Map<String, String> language = {
        'language_name': controller['language']!.text,
        'language_read': controller['read']!.text,
        'language_write': controller['write']!.text,
        'language_speak': controller['speak']!.text,
      };
      languageList.add(language);
    }

    final body = {
      "gender": _genderListInit.valueOrNull!.id ?? 0,
      "marital_status": _maritalStatusListInit.valueOrNull!.id ?? 0,
      "nationality": _nationalityListInit.valueOrNull!.id ?? 0,
      "date_of_birth": _selectDob.valueOrNull ?? '',
      "age": _age.valueOrNull ?? '',
      "blood_group": _bloodGroupListInit.valueOrNull!.id ?? 0,
      "personal_mail": personalMail.text,
      "personal_mobile": personalContact.text,
      "mother_tongue": _motherTongueListInit.valueOrNull!.id ?? 0,
      "father_name": fatherName.text,
      "father_aadhar_number": fatherAadhaarNumber.text,
      "father_dob": _selectFatherDob.valueOrNull ?? '',
      "father_age": _fatherAge.valueOrNull ?? '',
      "mother_name": motherName.text,
      "mother_aadhar_number": motherAadhaarNumber.text,
      "mother_dob": _selectMotherDob.valueOrNull ?? '',
      "mother_age": _motherAge.valueOrNull ?? '',
      "language": languageList,
    };

    Logger().d("Submit: $body");
    BlocProvider.of<AccountCrudBloc>(context).add(PersonalEvent(body: body));
  }

  void onUpdate(BuildContext context, Personal personal,
      List<Map<String, TextEditingController>> multiController) {
    List<Map<String, String>> languageList = [];

    for (var controller in multiController) {
      Map<String, String> language = {
        'language_name': controller['language']!.text,
        'language_read': controller['read']!.text,
        'language_write': controller['write']!.text,
        'language_speak': controller['speak']!.text,
      };

      languageList.add(language);
    }

    final body = {
      "personal_id": personal.id,
      "gender": _genderListInit.valueOrNull!.id ?? 0,
      "marital_status": _maritalStatusListInit.valueOrNull!.id ?? 0,
      "nationality": _nationalityListInit.valueOrNull!.id ?? 0,
      "date_of_birth": _selectDob.valueOrNull ?? '',
      "age": _age.valueOrNull ?? '',
      "blood_group": _bloodGroupListInit.valueOrNull!.id ?? 0,
      "personal_mail": personalMail.text,
      "personal_mobile": personalContact.text,
      "mother_tongue": _motherTongueListInit.valueOrNull!.id ?? 0,
      "father_name": fatherName.text,
      "father_aadhar_number": fatherAadhaarNumber.text,
      "father_dob": _selectFatherDob.valueOrNull ?? '',
      "father_age": _fatherAge.valueOrNull ?? '',
      "mother_name": motherName.text,
      "mother_aadhar_number": motherAadhaarNumber.text,
      "mother_dob": _selectMotherDob.valueOrNull ?? '',
      "mother_age": _motherAge.valueOrNull ?? '',
      "language": languageList,
    };

    Logger().d("Submit: $body");
    BlocProvider.of<AccountCrudBloc>(context).add(PersonalEvent(body: body));
  }
}
