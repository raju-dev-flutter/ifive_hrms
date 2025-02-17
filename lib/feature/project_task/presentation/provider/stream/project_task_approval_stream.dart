import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/core.dart';
import '../../../../feature.dart';

class ProjectTaskApprovalStream {
  ProjectTaskApprovalStream({required TaskDeptLeadUseCase taskDeptLeadUseCase})
      : _taskDeptLeadUseCase = taskDeptLeadUseCase;

  final TaskDeptLeadUseCase _taskDeptLeadUseCase;

  final descriptionController = TextEditingController();
  final percentageController = TextEditingController();

  // final _startDate = BehaviorSubject<DateTime?>();
  // final _endDate = BehaviorSubject<DateTime?>();
  //
  // final _selectedStartDate = BehaviorSubject<String>();
  // final _selectedEndDate = BehaviorSubject<String>();

  final _createdByInit = BehaviorSubject<String>();

  // final _projectList = BehaviorSubject<List<CommonList>>.seeded([]);
  // final _assignDepartmentList = BehaviorSubject<List<CommonList>>.seeded([]);
  // final _departmentLeadList = BehaviorSubject<List<CommonList>>.seeded([]);
  // final _assignedToList = BehaviorSubject<List<CommonList>>.seeded([]);
  //
  // final _projectListInit = BehaviorSubject<CommonList>();
  // final _assignDepartmentListInit = BehaviorSubject<CommonList>();
  // final _departmentLeadListInit = BehaviorSubject<CommonList>();
  // final _assignedToListInit = BehaviorSubject<CommonList>();

  // final _updateStatusList = BehaviorSubject<List<CommonList>>.seeded([]);
  // final _updateStatusListInit = BehaviorSubject<CommonList>();

  final _captureImageSubject = BehaviorSubject<List<File>>.seeded([]);

  ValueStream<List<File>> get captureImageSubject =>
      _captureImageSubject.stream;

  // ValueStream<DateTime?> get startDate => _startDate.stream;
  // ValueStream<DateTime?> get endDate => _endDate.stream;
  //
  // ValueStream<String> get selectedStartDate => _selectedStartDate.stream;
  // ValueStream<String> get selectedEndDate => _selectedEndDate.stream;

  ValueStream<String> get createdByInit => _createdByInit.stream;

  // Stream<List<CommonList>> get projectList => _projectList.stream;
  // Stream<List<CommonList>> get assignDepartmentList =>
  //     _assignDepartmentList.stream;
  // Stream<List<CommonList>> get departmentLeadList => _departmentLeadList.stream;
  // Stream<List<CommonList>> get assignedToList => _assignedToList.stream;
  // Stream<List<CommonList>> get updateStatusList => _updateStatusList.stream;
  //
  // ValueStream<CommonList> get projectListInit => _projectListInit.stream;
  // ValueStream<CommonList> get assignDepartmentListInit =>
  //     _assignDepartmentListInit.stream;
  // ValueStream<CommonList> get departmentLeadListInit =>
  //     _departmentLeadListInit.stream;
  // ValueStream<CommonList> get assignedToListInit => _assignedToListInit.stream;
  // ValueStream<CommonList> get updateStatusListInit =>
  //     _updateStatusListInit.stream;

  Future<void> fetchInitialCallBack(TaskData task) async {
    // Logger().w(task.taskManagerId);

    // _updateStatusList.sink.add([
    //   CommonList(id: 0, name: "Inprogress"),
    //   CommonList(id: 1, name: "Pending"),
    //   CommonList(id: 2, name: "Completed"),
    // ]);

    // final taskDeptRes = await _taskDeptLeadUseCase(
    //     TaskDeptLeadParams(taskId: (task.taskManagerId ?? 0).toString()));
    // taskDeptRes.fold(
    //   (_) => null,
    //   (_) => {
    //     _assignedToList.sink.add(_.taskAssignedTo ?? []),
    //     // _updateStatusList.sink.add(_.taskStatus ?? []),
    //   },
    // );
  }

  // void selectStartDate(DateTime date) {
  //   _startDate.sink.add(date);
  //   _selectedStartDate.sink.add(DateFormat('yyyy-MM-dd').format(date));
  // }
  //
  // void selectEndDate(DateTime date) {
  //   _endDate.sink.add(date);
  //   _selectedStartDate.sink.add(DateFormat('yyyy-MM-dd').format(date));
  // }
  //
  // void project(params) {
  //   _projectListInit.sink.add(CommonList(id: params.value, name: params.name));
  // }
  //
  // void assignDepartment(params) {
  //   _assignDepartmentListInit.sink
  //       .add(CommonList(id: params.value, name: params.name));
  // }
  //
  // void departmentLead(params) {
  //   _departmentLeadListInit.sink
  //       .add(CommonList(id: params.value, name: params.name));
  // }
  //
  // void assignedTo(params) {
  //   _assignedToListInit.sink
  //       .add(CommonList(id: params.value, name: params.name));
  // }
  //
  // void updateStatus(params) {
  //   _updateStatusListInit.sink
  //       .add(CommonList(id: params.value, name: params.name));
  // }

  void addCaptureImage(List<File> files) =>
      _captureImageSubject.sink.add(files);

  void removeCaptureImage() => _captureImageSubject.add([]);

  void onSubmit(BuildContext context, TaskData task, status) {
    final DataMap body = {
      "task_id": task.taskManagerId,
      "businessplan_line_id": task.businessPlanLineId,
      "task_status": status,
      "description": descriptionController.text,
    };

    final List<File> captureFile = _captureImageSubject.valueOrNull ?? [];

    Logger().i("Submit: $body");

    BlocProvider.of<ProjectTaskCrudBloc>(context)
        .add(ProjectTaskApprovalEvent(body: body, file: captureFile));
  }
}
