import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/core.dart';
import '../../../../feature.dart';

class SupportTaskStream {
  SupportTaskStream(
      {required EmployeeListUseCase employeeListUseCase,
      required TeamUseCase teamUseCase,
      required ProjectUseCase projectUseCase})
      : _employeeListUseCase = employeeListUseCase,
        _teamUseCase = teamUseCase,
        _projectUseCase = projectUseCase;

  final EmployeeListUseCase _employeeListUseCase;
  final TeamUseCase _teamUseCase;
  final ProjectUseCase _projectUseCase;

  late TextEditingController taskController = TextEditingController();
  late TextEditingController statusController = TextEditingController();
  late TextEditingController descriptionController = TextEditingController();

  final _statusList = BehaviorSubject<List<CommonList>>.seeded([]);
  final _statusListInit = BehaviorSubject<CommonList>();

  final _assignList = BehaviorSubject<List<CommonList>>.seeded([]);
  final _assignListInit = BehaviorSubject<CommonList>();

  final _givenByList = BehaviorSubject<List<CommonList>>.seeded([]);
  final _givenByListInit = BehaviorSubject<CommonList>();

  final _discussList = BehaviorSubject<List<CommonList>>.seeded([]);
  final _discussListInit = BehaviorSubject<CommonList>();

  final _typeList = BehaviorSubject<List<CommonList>>.seeded([]);
  final _typeListInit = BehaviorSubject<CommonList>();

  final _teamList = BehaviorSubject<List<CommonList>>.seeded([]);
  final _teamListInit = BehaviorSubject<CommonList>();

  final _projectList = BehaviorSubject<List<CommonList>>.seeded([]);
  final _projectListInit = BehaviorSubject<CommonList>();

  final _priorityList = BehaviorSubject<List<CommonList>>.seeded([]);
  final _priorityListInit = BehaviorSubject<CommonList>();

  final _startDate = BehaviorSubject<DateTime?>();
  final _selectStartDate = BehaviorSubject<String>.seeded('');

  final _endDate = BehaviorSubject<DateTime?>();
  final _selectEndDate = BehaviorSubject<String>.seeded('');

  final _startTime = BehaviorSubject<TimeOfDay?>();
  final _endTime = BehaviorSubject<TimeOfDay?>();

  final _selectStartTime = BehaviorSubject<String>();
  final _selectEndTime = BehaviorSubject<String>();

  final _startDateTime = BehaviorSubject<DateTime?>();
  final _endDateTime = BehaviorSubject<DateTime?>();

  Stream<List<CommonList>> get statusList => _statusList.stream;

  ValueStream<CommonList> get statusListInit => _statusListInit.stream;

  Stream<List<CommonList>> get assignList => _assignList.stream;

  ValueStream<CommonList> get assignListInit => _assignListInit.stream;

  Stream<List<CommonList>> get givenByList => _givenByList.stream;

  ValueStream<CommonList> get givenByListInit => _givenByListInit.stream;

  Stream<List<CommonList>> get typeList => _typeList.stream;

  ValueStream<CommonList> get typeListInit => _typeListInit.stream;

  Stream<List<CommonList>> get discussList => _discussList.stream;

  ValueStream<CommonList> get discussListInit => _discussListInit.stream;

  Stream<List<CommonList>> get teamList => _teamList.stream;

  ValueStream<CommonList> get teamListInit => _teamListInit.stream;

  Stream<List<CommonList>> get projectList => _projectList.stream;

  ValueStream<CommonList> get projectListInit => _projectListInit.stream;

  Stream<List<CommonList>> get priorityList => _priorityList.stream;

  ValueStream<CommonList> get priorityListInit => _priorityListInit.stream;

  ValueStream<DateTime?> get startDate => _startDate.stream;

  ValueStream<String?> get selectStartDate => _selectStartDate.stream;

  ValueStream<DateTime?> get endDate => _endDate.stream;

  ValueStream<String?> get selectEndDate => _selectEndDate.stream;

  ValueStream<TimeOfDay?> get startTime => _startTime.stream;

  ValueStream<TimeOfDay?> get endTime => _endTime.stream;

  ValueStream<String> get selectStartTime => _selectStartTime.stream;

  ValueStream<String> get selectEndTime => _selectEndTime.stream;

  ValueStream<DateTime?> get startDateTime => _startDateTime.stream;

  ValueStream<DateTime?> get endDateTime => _endDateTime.stream;

  void fetchInitialCallBack() async {
    _statusList.sink.add([
      CommonList(id: 1, name: "Created"),
      CommonList(id: 1, name: "Initiated"),
      CommonList(id: 2, name: "Pending"),
      CommonList(id: 3, name: "Completed"),
    ]);

    _statusListInit.sink.add(_statusList.valueOrNull?.first ?? CommonList());

    _typeList.sink.add([
      CommonList(id: 1, name: "Project"),
      CommonList(id: 2, name: "Demo"),
      CommonList(id: 3, name: "CR"),
      CommonList(id: 4, name: "SR"),
    ]);
    _typeListInit.sink.add(_typeList.valueOrNull?.first ?? CommonList());

    _priorityList.sink.add([
      CommonList(id: 1, name: "Low"),
      CommonList(id: 2, name: "Medium"),
      CommonList(id: 3, name: "High"),
      CommonList(id: 4, name: "Critical"),
      CommonList(id: 5, name: "Very Critical"),
    ]);
    _priorityListInit.sink
        .add(_priorityList.valueOrNull?.first ?? CommonList());

    final response = await _employeeListUseCase();
    response.fold((_) => {}, (_) {
      if (_.employeeList!.isNotEmpty) {
        _assignList.sink.add(_.employeeList ?? []);
        _discussList.sink.add(_.employeeList ?? []);
      } else {
        _assignList.sink.add([]);
        _discussList.sink.add([]);
      }
    });

    final teamResponse = await _teamUseCase();
    teamResponse.fold((_) => {}, (_) {
      if (_.teamList!.isNotEmpty) {
        _teamList.sink.add(_.teamList ?? []);
      } else {
        _teamList.sink.add([]);
      }
    });

    final projectResponse = await _projectUseCase();
    projectResponse.fold((_) => {}, (_) {
      if (_.projectList!.isNotEmpty) {
        _projectList.sink.add(_.projectList ?? []);
      } else {
        _projectList.sink.add([]);
      }
    });
  }

  void project(params) {
    _projectListInit.sink.add(CommonList(id: params.value, name: params.name));
  }

  void assignTo(params) {
    _assignListInit.sink.add(CommonList(id: params.value, name: params.name));
  }

  void givenBy(params) {
    _givenByListInit.sink.add(CommonList(id: params.value, name: params.name));
  }

  void priority(params) {
    _priorityListInit.sink.add(CommonList(id: params.value, name: params.name));
  }

  void team(params) {
    _teamListInit.sink.add(CommonList(id: params.value, name: params.name));
  }

  void discuss(params) {
    _discussListInit.sink.add(CommonList(id: params.value, name: params.name));
  }

  void type(params) {
    _typeListInit.sink.add(CommonList(id: params.value, name: params.name));
  }

  void status(params) {
    _statusListInit.sink.add(CommonList(id: params.value, name: params.name));
  }

  void selectedStartDate(DateTime date, BuildContext context) {
    _startDate.sink.add(date);
    _selectStartDate.sink.add(DateFormat('yyyy-MM-dd').format(date));
  }

  void selectedEndDate(DateTime date, BuildContext context) {
    _endDate.sink.add(date);
    _selectEndDate.sink.add(DateFormat('yyyy-MM-dd').format(date));
  }

  void selectedStartTime(BuildContext context, DateTime date, TimeOfDay time) {
    _startTime.sink.add(time);
    _startDateTime.sink
        .add(DateTime(date.year, date.month, date.day, time.hour, time.minute));
    _selectStartTime.sink.add(
        "${DateFormat('yyyy-MM-dd').format(date)} ${time.hour}:${time.minute}");
  }

  void selectedToTime(BuildContext context, DateTime date, TimeOfDay time) {
    _endTime.sink.add(time);
    _endDateTime.sink
        .add(DateTime(date.year, date.month, date.day, time.hour, time.minute));
    _selectEndTime.sink.add(
        "${DateFormat('yyyy-MM-dd').format(date)} ${time.hour}:${time.minute}");
  }

  Future<void> onSelfTaskSubmit(BuildContext context) async {
    final startTime = _startDateTime.valueOrNull;
    final endTime = _endDateTime.valueOrNull;
    Duration? duration;
    if (startTime != null || endTime != null) {
      duration = endTime!.difference(startTime!);
    }
    final taskDuration = startTime == null || endTime == null
        ? "00:00"
        : duration?.toString().split(".")[0];

    final body = {
      "task_method": "self",
      "task": taskController.text,
      "project_id": _projectListInit.valueOrNull?.id ?? 0,
      "type": _typeListInit.valueOrNull?.name ?? '',
      "priority": _priorityListInit.valueOrNull?.name ?? '',
      "status": _statusListInit.valueOrNull?.name ?? "Pending",
      "start_date": DateFormat("yyyy-MM-dd hh:mm:ss")
          .format(_startDate.valueOrNull ?? DateTime.now()),
      "end_date": DateFormat("yyyy-MM-dd hh:mm:ss")
          .format(_endDate.valueOrNull ?? DateTime.now()),
      "start_time": _startTime.valueOrNull == null
          ? ''
          : _selectStartTime.valueOrNull ?? '',
      "end_time":
          _endTime.valueOrNull == null ? '' : _selectEndTime.valueOrNull ?? '',
      "task_duration": taskDuration,
      // "team": _teamListInit.valueOrNull?.id ?? 0,
      "discuss": _discussListInit.valueOrNull?.name ?? '',
      "description": descriptionController.text,
    };

    BlocProvider.of<TaskCrudBloc>(context)
        .add(CreateSupportTaskEvent(body: body));
  }

  Future<void> onAssignTaskSubmit(BuildContext context) async {
    final startTime = _startDateTime.valueOrNull;
    final endTime = _endDateTime.valueOrNull;
    Duration? duration;
    if (startTime != null || endTime != null) {
      duration = endTime!.difference(startTime!);
    }
    final taskDuration = startTime == null || endTime == null
        ? "00:00"
        : duration?.toString().split(".")[0];

    final body = {
      "task_method": "assign",
      "task": taskController.text,
      "project_id": _projectListInit.valueOrNull?.id ?? 0,
      "type": _typeListInit.valueOrNull?.name ?? '',
      "priority": _priorityListInit.valueOrNull?.name ?? '',
      "status": _statusListInit.valueOrNull?.name ?? "Pending",
      "start_date": DateFormat("yyyy-MM-dd hh:mm:ss")
          .format(_startDate.valueOrNull ?? DateTime.now()),
      "end_date": DateFormat("yyyy-MM-dd hh:mm:ss")
          .format(_endDate.valueOrNull ?? DateTime.now()),
      "start_time": _startTime.valueOrNull == null
          ? ''
          : _selectStartTime.valueOrNull ?? '',
      "end_time":
          _endTime.valueOrNull == null ? '' : _selectEndTime.valueOrNull ?? '',
      "task_duration": taskDuration,
      "assign_to": _assignListInit.valueOrNull?.id ?? 0,
      // "team": _teamListInit.valueOrNull?.id ?? 0,
      "discuss": _discussListInit.valueOrNull?.name ?? '',
      "description": descriptionController.text,
    };

    BlocProvider.of<TaskCrudBloc>(context)
        .add(CreateSupportTaskEvent(body: body));
  }
}
