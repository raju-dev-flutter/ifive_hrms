import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/core.dart';
import '../../../../feature.dart';

class TaskTestL1Stream {
  TaskTestL1Stream({required EmployeeListUseCase employeeListUseCase})
      : _employeeListUseCase = employeeListUseCase;

  final EmployeeListUseCase _employeeListUseCase;

  late TextEditingController percentageController = TextEditingController();

  final _statusList = BehaviorSubject<List<CommonList>>.seeded([]);

  final _statusListInit = BehaviorSubject<CommonList>();

  final _userList = BehaviorSubject<List<CommonList>>.seeded([]);

  final _userListInit = BehaviorSubject<CommonList>();

  final _deliveryTeamList = BehaviorSubject<List<CommonList>>.seeded([]);

  final _deliveryTeamListInit = BehaviorSubject<CommonList>();

  Stream<List<CommonList>> get userList => _userList.stream;

  ValueStream<CommonList> get userListInit => _userListInit.stream;

  Stream<List<CommonList>> get deliveryTeamList => _deliveryTeamList.stream;

  ValueStream<CommonList> get deliveryTeamListInit =>
      _deliveryTeamListInit.stream;

  Stream<List<CommonList>> get statusList => _statusList.stream;

  ValueStream<CommonList> get statusListInit => _statusListInit.stream;

  /*
    'Initiated',
    'Pending',
    'In Progress',
    'Testing L1',
    'Testing L2',
    'Completed'
    */

  Future<void> fetchInitialCallBack() async {
    _statusList.sink.add([
      CommonList(id: 1, name: "Rework L1"),
      CommonList(id: 2, name: "Testing L2"),
    ]);

    final response = await _employeeListUseCase();
    response.fold((_) => {}, (_) {
      if (_.employeeList!.isNotEmpty) {
        _userList.sink.add(_.employeeList ?? []);
        _deliveryTeamList.sink.add(_.employeeList ?? []);
      } else {
        _userList.sink.add([]);
        _deliveryTeamList.sink.add([]);
      }
    });
  }

  void status(params) {
    _statusListInit.sink.add(CommonList(id: params.value, name: params.name));
  }

  void assignTo(params) {
    _userListInit.sink.add(CommonList(id: params.value, name: params.name));
    _deliveryTeamListInit.sink.add(CommonList());
  }

  void deliveryTeam(params) {
    _deliveryTeamListInit.sink
        .add(CommonList(id: params.value, name: params.name));
    _userListInit.sink.add(CommonList());
  }

  Future<void> onSubmit(BuildContext context, TaskPlanner planner) async {
    final body = {
      "taskplanner_id": planner.taskPlannerId,
      // "task_status_id": planner.taskTimeHistory?.first.taskStatusId,
      "start_time": DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now()),

      "status": "Testing L1",
      // "percentage": percentageController.text,
      // "assign_to": _userListInit.valueOrNull?.id ?? '',
      // "delivary_team": _deliveryTeamListInit.valueOrNull?.id ?? '',
    };

    BlocProvider.of<TaskCrudBloc>(context)
        .add(TaskTestL1UpdateEvent(body: body));
  }

  String timeFormat(String time) {
    final splitTime = time.split(' ').last.split('.').first.split(':');
    return "${splitTime[0]}:${splitTime[1]}";
  }

  Future<void> onEndSubmit(BuildContext context, TaskPlanner planner) async {
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
      // "status": "Testing L1",
      "status": _statusListInit.valueOrNull?.name ?? "",
      // "percentage": percentageController.text,
      // "assign_to": _userListInit.valueOrNull?.id ?? '',
      "delivary_team": _deliveryTeamListInit.valueOrNull?.id ?? '',
    };

    BlocProvider.of<TaskCrudBloc>(context)
        .add(TaskTestL1UpdateEvent(body: body));
  }
}
