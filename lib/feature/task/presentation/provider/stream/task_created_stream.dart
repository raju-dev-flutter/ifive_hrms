import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/core.dart';
import '../../../../feature.dart';

class TaskCreatedStream {
  TaskCreatedStream({required EmployeeListUseCase employeeListUseCase})
      : _employeeListUseCase = employeeListUseCase;

  final EmployeeListUseCase _employeeListUseCase;

  late TextEditingController statusController = TextEditingController();

  final _userList = BehaviorSubject<List<CommonList>>.seeded([]);

  final _userListInit = BehaviorSubject<CommonList>();

  final _filterUserList = BehaviorSubject<List<CommonList>>.seeded([]);

  Stream<List<CommonList>> get userList => _userList.stream;

  ValueStream<CommonList> get userListInit => _userListInit.stream;

  Stream<List<CommonList>> get filterUserList => _filterUserList.stream;

  Future<void> fetchInitialCallBack() async {
    statusController = TextEditingController(text: "Initiated");
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
    // _userListInit.sink.add(CommonList(id: params.value, name: params.name));
  }

  void assignTo(params) {
    _userListInit.sink.add(CommonList(id: params.value, name: params.name));
  }

  void selectAssignTo(params) {
    _userListInit.sink.add(params);
  }

  Future<void> onSubmit(BuildContext context, TaskPlanner planner) async {
    final body = {
      "assign_to": _userListInit.valueOrNull?.id ?? 0,
      "taskplanner_id": planner.taskPlannerId,
      "status": "Initiated"
    };

    BlocProvider.of<TaskCrudBloc>(context)
        .add(TaskInitiatedUpdateEvent(body: body));
  }
}
