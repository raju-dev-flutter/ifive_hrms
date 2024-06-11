import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/core.dart';
import '../../../account.dart';

class ProfileEducationStream {
  ProfileEducationStream(
      {required EducationLevelUseCase $EducationLevelUseCase})
      : _$EducationLevelUseCase = $EducationLevelUseCase;

  final EducationLevelUseCase _$EducationLevelUseCase;

  final _isLoading = BehaviorSubject<bool>.seeded(false);

  late TextEditingController course = TextEditingController();
  late TextEditingController nameOfTheInstitution = TextEditingController();
  late TextEditingController boardsOfEducation = TextEditingController();
  late TextEditingController percentage = TextEditingController();

  final _educationLevel = BehaviorSubject<List<CommonList>>.seeded([]);
  final _educationLevelListInit = BehaviorSubject<CommonList>();

  final _fromDate = BehaviorSubject<DateTime?>();
  final _toDate = BehaviorSubject<DateTime?>();

  final _selectFromDate = BehaviorSubject<String>();
  final _selectToDate = BehaviorSubject<String>();

  final _file = BehaviorSubject<File?>();

  ValueStream<bool> get isLoading => _isLoading.stream;

  Stream<List<CommonList>> get educationLevel => _educationLevel.stream;

  ValueStream<CommonList> get educationLevelListInit =>
      _educationLevelListInit.stream;

  ValueStream<DateTime?> get fromDate => _fromDate.stream;
  ValueStream<DateTime?> get toDate => _toDate.stream;

  ValueStream<String> get selectFromDate => _selectFromDate.stream;
  ValueStream<String> get selectToDate => _selectToDate.stream;

  ValueStream<File?> get file => _file.stream;

  Future<void> fetchInitialCallBack() async {
    final response = await _$EducationLevelUseCase();
    response.fold(
      (_) => {_educationLevel.add([])},
      (_) {
        if (_.educationLevel!.isNotEmpty) {
          _educationLevel.add(_.educationLevel ?? []);
        }
      },
    );
  }

  void fetchInitialCallBackWithDetail(Education? education) async {
    _isLoading.sink.add(true);

    course = TextEditingController(text: education!.course ?? '');
    nameOfTheInstitution =
        TextEditingController(text: education.schoolName ?? '');
    boardsOfEducation =
        TextEditingController(text: education.schoolBoard ?? '');
    percentage = TextEditingController(text: education.percentage ?? '');

    _selectFromDate.sink.add(education.fromDate ?? '');
    _selectToDate.sink.add(education.toDate ?? '');

    final response = await _$EducationLevelUseCase();
    response.fold(
      (_) => {_educationLevel.add([])},
      (_) {
        if (_.educationLevel!.isNotEmpty) {
          _educationLevel.add(_.educationLevel ?? []);
          for (var edu in _.educationLevel!) {
            if (edu.id == int.parse(education.educationLevel ?? '0')) {
              _educationLevelListInit.sink.add(edu);
              break;
            }
          }
        }
      },
    );
    _isLoading.sink.add(false);
  }

  void selectedEducationLevel(val) {
    _educationLevelListInit.sink.add(CommonList(id: val.value, name: val.name));
  }

  void selectedFromDate(DateTime date) {
    _fromDate.sink.add(date);
    _selectFromDate.sink.add(DateFormat('yyyy-MM-dd').format(date));
  }

  void selectedToDate(DateTime date) {
    _toDate.sink.add(date);
    _selectToDate.sink.add(DateFormat('yyyy-MM-dd').format(date));
  }

  void selectedFile() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickMedia();
    if (pickedFile != null) _file.sink.add(File(pickedFile.path));
  }

  void removeFile() async => _file.sink.add(null);

  void onSubmit(BuildContext context) {
    final body = {
      "course": course.text,
      "education_level": _educationLevelListInit.valueOrNull!.id ?? 0,
      "institution": nameOfTheInstitution.text,
      "boards_of_eu": boardsOfEducation.text,
      "from_date": _selectFromDate.valueOrNull ?? '',
      "to_date": _selectToDate.valueOrNull ?? '',
      "percentage": percentage.text,
    };

    Logger().d("Submit: $body");
    final file = _file.valueOrNull;
    BlocProvider.of<AccountCrudBloc>(context)
        .add(EducationEvent(body: body, files: file));
  }

  void onUpdate(BuildContext context, Education education) {
    final body = {
      "education_id": education.id,
      "course": course.text,
      "education_level": _educationLevelListInit.valueOrNull!.id ?? 0,
      "institution": nameOfTheInstitution.text,
      "boards_of_eu": boardsOfEducation.text,
      "from_date": _selectFromDate.valueOrNull ?? '',
      "to_date": _selectToDate.valueOrNull ?? '',
      "percentage": percentage.text,
    };

    Logger().d("Submit: $body");
    final file = _file.valueOrNull;
    BlocProvider.of<AccountCrudBloc>(context)
        .add(EducationEvent(body: body, files: file));
  }

  void onDelete(BuildContext context, Education education) {
    final body = {
      "education_id": education.id,
      "education_status": 'delete',
    };

    final file = _file.valueOrNull;
    BlocProvider.of<AccountCrudBloc>(context)
        .add(EducationEvent(body: body, files: file));
  }

  void onClose() {
    _educationLevelListInit.sink.add(CommonList());
    course.clear();
    nameOfTheInstitution.clear();
    boardsOfEducation.clear();
    percentage.clear();
    _selectFromDate.sink.add('');
    _selectToDate.sink.add('');
    _fromDate.sink.add(null);
    _toDate.sink.add(null);
    _file.sink.add(null);
  }
}
