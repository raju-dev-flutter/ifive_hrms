import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/core.dart';
import '../../../../feature.dart';

class TaskInProgressStream {
  TaskInProgressStream({required EmployeeListUseCase employeeListUseCase})
      : _employeeListUseCase = employeeListUseCase;

  final EmployeeListUseCase _employeeListUseCase;

  late TextEditingController percentageController = TextEditingController();

  final _statusList = BehaviorSubject<List<CommonList>>.seeded([]);

  final _statusListInit = BehaviorSubject<CommonList>();

  final _userList = BehaviorSubject<List<CommonList>>.seeded([]);

  final _userListInit = BehaviorSubject<CommonList>();

  final _filterUserList = BehaviorSubject<List<CommonList>>.seeded([]);

  Stream<List<CommonList>> get userList => _userList.stream;

  ValueStream<CommonList> get userListInit => _userListInit.stream;

  Stream<List<CommonList>> get statusList => _statusList.stream;

  ValueStream<CommonList> get statusListInit => _statusListInit.stream;

  Stream<List<CommonList>> get filterUserList => _filterUserList.stream;

  Future<void> fetchInitialCallBack() async {
    _statusList.sink.add([
      CommonList(id: 1, name: "Pending"),
      CommonList(id: 2, name: "Testing L1"),
    ]);

    final response = await _employeeListUseCase();
    response.fold((_) => {}, (_) {
      if (_.employeeList!.isNotEmpty) {
        _userList.sink.add(_.employeeList ?? []);
      } else {
        _userList.sink.add([]);
      }
    });
  }

  void filterUser(String params) {
    _filterUserList.sink.add(_userList.valueOrNull!
        .where(
            (user) => user.name!.toLowerCase().contains(params.toLowerCase()))
        .toList());
  }

  void status(params) {
    _statusListInit.sink.add(CommonList(id: params.value, name: params.name));
  }

  selectAssignTo(CommonList user) {
    _userListInit.sink.add(user);
  }

  void assignTo(params) {
    _userListInit.sink.add(CommonList(id: params.value, name: params.name));
  }

  Future<void> onSubmit(BuildContext context, TaskPlanner planner) async {
    // final body = {
    //   "taskplanner_id": planner.taskPlannerId,
    //   "task_status_id": planner.taskTimeHistory?.first.taskStatusId,
    //   "end_time": DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now()),
    //   "status": _statusListInit.valueOrNull?.name ?? "In Progress",
    //   "tested_by": _userListInit.valueOrNull?.id ?? 0,
    //   "assign_to": _userListInit.valueOrNull?.id ?? 0,
    //   "percentage": percentageController.text,
    // };
    final body = {
      "taskplanner_id": planner.taskPlannerId,
      "start_time": DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now()),
      "status": "In Progress",
      // "tested_by": _userListInit.valueOrNull?.id ?? 0,
      // "assign_to": _userListInit.valueOrNull?.id ?? 0,
      // "percentage": percentageController.text,
    };
    BlocProvider.of<TaskCrudBloc>(context)
        .add(TaskInProgressUpdateEvent(body: body));
  }

  String timeFormat(String time) {
    final splitTime = time.split(' ').last.split('.').first.split(':');
    return "${splitTime[0]}:${splitTime[1]}";
  }

  Future<void> onEndSubmit(BuildContext context, TaskPlanner planner) async {
    // final body = {
    //   "taskplanner_id": planner.taskPlannerId,
    //   "task_status_id": planner.taskTimeHistory?.first.taskStatusId,
    //   "end_time": DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now()),
    //   "status": _statusListInit.valueOrNull?.name ?? "In Progress",
    //   "tested_by": _userListInit.valueOrNull?.id ?? 0,
    //   "assign_to": _userListInit.valueOrNull?.id ?? 0,
    //   "percentage": percentageController.text,
    // };
    var taskStatusId = 0;
    for (var i = 0; i < planner.taskTimeHistory!.length; i++) {
      if (timeFormat(planner.taskTimeHistory![i].taskStartTime ?? "") !=
              "00:00" &&
          timeFormat(planner.taskTimeHistory![i].taskEndTime ?? "") ==
              "00:00") {
        taskStatusId = planner.taskTimeHistory![i].taskStatusId ?? 0;
        break;
      }
    }

    final body = {
      "taskplanner_id": planner.taskPlannerId,
      "task_status_id": taskStatusId,
      "end_time": DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now()),
      "status": "In Progress",
      "percentage": percentageController.text,
    };
    BlocProvider.of<TaskCrudBloc>(context)
        .add(TaskInProgressUpdateEvent(body: body));
    percentageController.clear();
  }
}
