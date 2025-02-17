import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifive_hrms/core/core.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../feature.dart';

class ProjectTaskRequestStream {
  ProjectTaskRequestStream(
      {required ProjectTaskDropdownUseCase projectTaskDropdownUseCase})
      : _projectTaskDropdownUseCase = projectTaskDropdownUseCase;

  final ProjectTaskDropdownUseCase _projectTaskDropdownUseCase;

  final activityController = TextEditingController();
  final addressController = TextEditingController();
  final commentsController = TextEditingController();

  final _projectList = BehaviorSubject<List<CommonList>>.seeded([]);
  final _projectListInit = BehaviorSubject<CommonList>.seeded(CommonList());

  final _departmentList = BehaviorSubject<List<CommonList>>.seeded([]);
  final _departmentListInit = BehaviorSubject<CommonList>.seeded(CommonList());

  final _leadResponsibilityList = BehaviorSubject<List<CommonList>>.seeded([]);
  final _leadResponsibilityListInit =
      BehaviorSubject<CommonList>.seeded(CommonList());

  final _approveByList = BehaviorSubject<List<CommonList>>.seeded([]);
  final _approveByListInit = BehaviorSubject<CommonList>.seeded(CommonList());

  final _typeList = BehaviorSubject<List<CommonList>>.seeded([]);
  final _typeListInit = BehaviorSubject<CommonList>.seeded(CommonList());

  final _startDate = BehaviorSubject<DateTime?>();
  final _endDate = BehaviorSubject<DateTime?>();

  final _selectedStartDate = BehaviorSubject<String>();
  final _selectedEndDate = BehaviorSubject<String>();

  final _captureImageSubject = BehaviorSubject<List<File>>.seeded([]);

  ValueStream<List<File>> get captureImageSubject =>
      _captureImageSubject.stream;

  ValueStream<DateTime?> get startDate => _startDate.stream;

  ValueStream<DateTime?> get endDate => _endDate.stream;

  ValueStream<String> get selectedStartDate => _selectedStartDate.stream;

  ValueStream<String> get selectedEndDate => _selectedEndDate.stream;

  Stream<List<CommonList>> get projectList => _projectList.stream;

  ValueStream<CommonList> get projectListInit => _projectListInit.stream;

  Stream<List<CommonList>> get departmentList => _departmentList.stream;

  ValueStream<CommonList> get departmentListInit => _departmentListInit.stream;

  Stream<List<CommonList>> get leadResponsibilityList =>
      _leadResponsibilityList.stream;

  ValueStream<CommonList> get leadResponsibilityListInit =>
      _leadResponsibilityListInit.stream;

  Stream<List<CommonList>> get approveByList => _approveByList.stream;

  ValueStream<CommonList> get approveByListInit => _approveByListInit.stream;

  Stream<List<CommonList>> get typeList => _typeList.stream;

  ValueStream<CommonList> get typeListInit => _typeListInit.stream;

  Future<void> fetchInitialCallBack() async {
    final response = await _projectTaskDropdownUseCase();
    response.fold(
      (_) {},
      (res) {
        if (res.project!.isNotEmpty) {
          _projectList.sink.add(res.project ?? []);
        }
        if (res.department!.isNotEmpty) {
          _departmentList.sink.add(res.department ?? []);
        }
        if (res.leadResponse!.isNotEmpty) {
          _leadResponsibilityList.sink.add(res.leadResponse ?? []);
        }
        if (res.approver!.isNotEmpty) {
          _approveByList.sink.add(res.approver ?? []);
        }
        Logger().i(res.taskType);
        if (res.taskType!.isNotEmpty) {
          _typeList.sink.add(res.taskType ?? []);
        }
      },
    );
  }

  void department(params) {
    _projectListInit.sink.add(CommonList(id: params.value, name: params.name));
  }

  void project(params) {
    _departmentListInit.sink
        .add(CommonList(id: params.value, name: params.name));
  }

  void leadResponsibility(params) {
    _leadResponsibilityListInit.sink
        .add(CommonList(id: params.value, name: params.name));
  }

  void approveBy(params) {
    _approveByListInit.sink
        .add(CommonList(id: params.value, name: params.name));
  }

  void addCaptureImage(List<File> files) =>
      _captureImageSubject.sink.add(files);

  void removeCaptureImage() => _captureImageSubject.add([]);

  void type(params) {
    _typeListInit.sink.add(CommonList(id: params.value, name: params.name));
  }

  void selectStartDate(DateTime date) {
    _startDate.sink.add(date);
    _selectedStartDate.sink.add(DateFormat('yyyy-MM-dd').format(date));
  }

  void selectEndDate(DateTime date) {
    _endDate.sink.add(date);
    _selectedEndDate.sink.add(DateFormat('yyyy-MM-dd').format(date));
  }

  void onSubmit(BuildContext context) {
    final DataMap body = {
      "project_id": _projectListInit.valueOrNull!.id ?? 0,
      "activity": activityController.text,
      "department_id": _departmentListInit.valueOrNull!.id ?? 0,
      "lead_responsibility_id":
          _leadResponsibilityListInit.valueOrNull!.id ?? 0,
      "approve_by_id": _approveByListInit.valueOrNull!.id ?? 0,
      "type": _typeListInit.valueOrNull!.name ?? "",
      "start_date": _selectedStartDate.valueOrNull ?? "",
      "end_date": _selectedEndDate.valueOrNull ?? "",
      "address": addressController.text,
      "comments": commentsController.text,
    };

    final List<File> captureFile = _captureImageSubject.valueOrNull ?? [];

    Logger().i("Submit: $body");

    BlocProvider.of<ProjectTaskCrudBloc>(context)
        .add(ProjectTaskSaveEvent(body: body, file: captureFile));
  }
}
