import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';

import '../../../account.dart';

class ProfileExperienceStream {
  ProfileExperienceStream();

  late TextEditingController organizationName = TextEditingController();
  late TextEditingController organizationWebsite = TextEditingController();
  late TextEditingController designation = TextEditingController();
  late TextEditingController ctc = TextEditingController();
  late TextEditingController reasonForLeaving = TextEditingController();

  final _fromDate = BehaviorSubject<DateTime?>();
  final _toDate = BehaviorSubject<DateTime?>();

  final _selectFromDate = BehaviorSubject<String>();
  final _selectToDate = BehaviorSubject<String>();

  final _experienceYears = BehaviorSubject<String>();

  final _file = BehaviorSubject<File?>();

  ValueStream<DateTime?> get fromDate => _fromDate.stream;
  ValueStream<DateTime?> get toDate => _toDate.stream;

  ValueStream<String> get selectFromDate => _selectFromDate.stream;
  ValueStream<String> get selectToDate => _selectToDate.stream;

  ValueStream<String> get experienceYears => _experienceYears.stream;

  ValueStream<File?> get file => _file.stream;

  Future<void> fetchInitialCallBack() async {}

  void fetchInitialCallBackWithDetail(Experience? experience) {
    organizationName =
        TextEditingController(text: experience!.organizationName ?? '');
    organizationWebsite =
        TextEditingController(text: experience.organizationWebsite ?? '');
    designation = TextEditingController(text: experience.designation ?? '');
    ctc = TextEditingController(text: (experience.ctc ?? '').toString());
    reasonForLeaving =
        TextEditingController(text: experience.reasonLeaving ?? '');

    _selectFromDate.sink.add(experience.fromDate ?? '');
    _selectToDate.sink.add(experience.toDate ?? '');
    _experienceYears.sink.add(experience.experienceType ?? '');
  }

  void selectedFromDate(DateTime date) {
    _fromDate.sink.add(date);
    _selectFromDate.sink.add(DateFormat('yyyy-MM-dd').format(date));
    calculateExperienceYears();
  }

  void selectedToDate(DateTime date) {
    _toDate.sink.add(date);
    _selectToDate.sink.add(DateFormat('yyyy-MM-dd').format(date));
    calculateExperienceYears();
  }

  void selectedFile() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickMedia();
    if (pickedFile != null) _file.sink.add(File(pickedFile.path));
  }

  void calculateExperienceYears() async {
    if (_fromDate.valueOrNull != null && _toDate.valueOrNull != null) {
      Duration difference =
          _toDate.valueOrNull!.difference(_fromDate.valueOrNull!);
      _experienceYears.sink.add((difference.inDays / 365).floor().toString());
    }
  }

  void removeFile() async => _file.sink.add(null);

  void onSubmit(BuildContext context) {
    final body = {
      "organization_name": organizationName.text,
      "organization_website": organizationWebsite.text,
      "designation": designation.text,
      "ctc": ctc.text,
      "from_date": _selectFromDate.valueOrNull ?? '',
      "to_date": _selectToDate.valueOrNull ?? '',
      "experience_years": _experienceYears.valueOrNull ?? '',
      "reason_leaving": reasonForLeaving.text,
    };

    Logger().d("Submit: $body");
    final file = _file.valueOrNull;
    BlocProvider.of<AccountCrudBloc>(context)
        .add(ExperienceEvent(body: body, file: file));
  }

  void onUpdate(BuildContext context, Experience experience) {
    final body = {
      "experience_id": experience.id,
      "organization_name": organizationName.text,
      "organization_website": organizationWebsite.text,
      "designation": designation.text,
      "ctc": ctc.text,
      "from_date": _selectFromDate.valueOrNull ?? '',
      "to_date": _selectToDate.valueOrNull ?? '',
      "experience_years": _experienceYears.valueOrNull ?? '',
      "reason_leaving": reasonForLeaving.text,
    };

    Logger().d("Submit: $body");
    final file = _file.valueOrNull;
    BlocProvider.of<AccountCrudBloc>(context)
        .add(ExperienceEvent(body: body, file: file));
  }

  void onDelete(BuildContext context, Experience experience) {
    final body = {
      "experience_id": experience.id,
      "experience_status": 'delete'
    };

    Logger().d("Submit: $body");
    final file = _file.valueOrNull;
    BlocProvider.of<AccountCrudBloc>(context)
        .add(ExperienceEvent(body: body, file: file));
  }

  void onClose() {
    organizationName.clear();
    organizationWebsite.clear();
    designation.clear();
    ctc.clear();
    reasonForLeaving.clear();
    _fromDate.sink.add(null);
    _toDate.sink.add(null);
    _selectFromDate.sink.add('');
    _selectToDate.sink.add('');
    _experienceYears.sink.add('');
    _file.add(null);
  }
}
