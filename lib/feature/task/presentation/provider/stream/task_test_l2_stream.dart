import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/core.dart';
import '../../../../feature.dart';

class TaskTestL2Stream {
  TaskTestL2Stream({required TeamUseCase teamUseCase})
      : _teamUseCase = teamUseCase;

  final TeamUseCase _teamUseCase;

  late TextEditingController descriptionController = TextEditingController();

  final _statusList = BehaviorSubject<List<CommonList>>.seeded([]);

  final _statusListInit = BehaviorSubject<CommonList>();

  final _userList = BehaviorSubject<List<CommonList>>.seeded([]);

  final _userListInit = BehaviorSubject<CommonList>();

  Stream<List<CommonList>> get userList => _userList.stream;

  ValueStream<CommonList> get userListInit => _userListInit.stream;

  Stream<List<CommonList>> get statusList => _statusList.stream;

  ValueStream<CommonList> get statusListInit => _statusListInit.stream;

  Future<void> fetchInitialCallBack() async {
    _statusList.sink.add([
      CommonList(id: 1, name: "Rework"),
      CommonList(id: 4, name: "Completed"),
    ]);

    final response = await _teamUseCase();
    response.fold((_) => {}, (_) {
      if (_.teamList!.isNotEmpty) {
        _userList.sink.add(_.teamList ?? []);
      } else {
        _userList.sink.add([]);
      }
    });
  }

  void status(params) {
    _statusListInit.sink.add(CommonList(id: params.value, name: params.name));
  }

  void assignTo(params) {
    _userListInit.sink.add(CommonList(id: params.value, name: params.name));
  }

  Future<void> onSubmit(BuildContext context, TaskPlanner planner) async {
    final body = {
      "taskplanner_id": planner.taskPlannerId,
      "task_status_id": planner.taskTimeHistory?.first.taskStatusId ?? '',
      "end_time": DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now()),
      "status": _statusListInit.valueOrNull?.name ?? "",
      "rework_remarks": descriptionController.text,
      "assign_to": _userListInit.valueOrNull?.id ?? '',
    };

    BlocProvider.of<TaskCrudBloc>(context)
        .add(TaskTestL2UpdateEvent(body: body));
  }
}
