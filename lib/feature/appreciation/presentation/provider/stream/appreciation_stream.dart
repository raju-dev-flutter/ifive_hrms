import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/core.dart';
import '../../../appreciation.dart';

class AppreciationStream {
  AppreciationStream({required EmployeeUserListUserCase employeeListUserCase})
      : _employeeListUserCase = employeeListUserCase;

  final EmployeeUserListUserCase _employeeListUserCase;

  final descriptionController = TextEditingController();

  final _employeeList = BehaviorSubject<List<CommonList>>.seeded([]);

  final _employeeListInit = BehaviorSubject<CommonList>();

  Stream<List<CommonList>> get employeeList => _employeeList.stream;

  ValueStream<CommonList> get employeeListInit => _employeeListInit.stream;

  Future<void> fetchInitiateCallBack() async {
    final employeeResponse = await _employeeListUserCase.call();

    employeeResponse.fold(
      (l) => {},
      (employee) {
        if (employee.employeeList!.isNotEmpty) {
          _employeeList.sink.add(employee.employeeList ?? []);
        } else {
          _employeeList.sink.add([]);
        }
      },
    );
  }

  void employee(val) {
    _employeeListInit.sink.add(CommonList(id: val.value, name: val.name));
  }

  void onSubmit(BuildContext context) {
    final appreciationCrud =
        BlocProvider.of<AppreciationCrudBloc>(context, listen: false);

    final body = {
      "id": _employeeListInit.valueOrNull!.id ?? 0,
      "desc": descriptionController.text
    };

    Logger().t("Create Appreciation: \n$body");

    appreciationCrud.add(CreateAppreciationEvent(body: body));
  }
}
