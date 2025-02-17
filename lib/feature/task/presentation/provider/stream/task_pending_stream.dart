import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/core.dart';
import '../../../../feature.dart';

class TaskPendingStream {
  final _statusList = BehaviorSubject<List<CommonList>>.seeded([]);

  final _statusListInit = BehaviorSubject<CommonList>();

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
      CommonList(id: 1, name: "In Progress"),
      CommonList(id: 2, name: "Testing L1"),
      CommonList(id: 3, name: "Testing L2"),
      CommonList(id: 4, name: "Completed"),
    ]);
  }

  void status(params) {
    _statusListInit.sink.add(CommonList(id: params.value, name: params.name));
  }

  Future<void> onSubmit(BuildContext context, TaskPlanner planner) async {
    final body = {
      "taskplanner_id": planner.taskPlannerId,
      // "start_time": DateTime.now().toString(),
      // "start_time": DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now()),
      // "start_time": TimeOfDay.fromDateTime(DateTime.now()).format(context),
      // "status": _statusListInit.valueOrNull!.name ?? "In Progress",
      "status": "In Progress",
    };

    BlocProvider.of<TaskCrudBloc>(context)
        .add(TaskPendingUpdateEvent(body: body));
  }
}
