import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/core.dart';
import '../../../../feature.dart';

class OtherTaskStream {
  OtherTaskStream({
    required EmployeeListUseCase employeeListUseCase,
  }) : _employeeListUseCase = employeeListUseCase;

  final EmployeeListUseCase _employeeListUseCase;

  late TextEditingController taskController = TextEditingController();

  late TextEditingController descriptionController = TextEditingController();

  final _assignList = BehaviorSubject<List<CommonList>>.seeded([]);
  final _assignListInit = BehaviorSubject<CommonList>();

  final _leadList = BehaviorSubject<List<CommonList>>.seeded([]);
  final _leadListInit = BehaviorSubject<CommonList>();

  final _taskTypeList = BehaviorSubject<List<Map<String, dynamic>>>();
  final _taskTypeInit = BehaviorSubject<String>();

  final _taskDayList = BehaviorSubject<List<CommonList>>.seeded([]);
  final _taskDayListInit = BehaviorSubject<CommonList>();

  final _startDate = BehaviorSubject<DateTime?>();

  final _endDate = BehaviorSubject<DateTime?>();

  final _startTime = BehaviorSubject<TimeOfDay?>();
  final _endTime = BehaviorSubject<TimeOfDay?>();

  final _selectStartTime = BehaviorSubject<String>();
  final _selectEndTime = BehaviorSubject<String>();

  final _startDateTime = BehaviorSubject<DateTime?>();
  final _endDateTime = BehaviorSubject<DateTime?>();

  Stream<List<CommonList>> get assignList => _assignList.stream;

  ValueStream<CommonList> get assignListInit => _assignListInit.stream;

  Stream<List<CommonList>> get leadList => _leadList.stream;

  ValueStream<CommonList> get leadListInit => _leadListInit.stream;

  Stream<String> get taskTypeInit => _taskTypeInit.stream;

  ValueStream<List<Map<String, dynamic>>> get taskTypeList =>
      _taskTypeList.stream;

  Stream<List<CommonList>> get taskDayList => _taskDayList.stream;

  ValueStream<CommonList> get taskDayListInit => _taskDayListInit.stream;

  ValueStream<TimeOfDay?> get startTime => _startTime.stream;

  ValueStream<TimeOfDay?> get endTime => _endTime.stream;

  ValueStream<String> get selectStartTime => _selectStartTime.stream;

  ValueStream<String> get selectEndTime => _selectEndTime.stream;

  ValueStream<DateTime?> get startDateTime => _startDateTime.stream;

  ValueStream<DateTime?> get endDateTime => _endDateTime.stream;

  void fetchInitialCallBack() async {
    _taskTypeList.sink.add([
      {"id": 0, "key": "daily", "name": "If It's Daily Task"},
      {"id": 1, "key": "weekly", "name": "If It's Weekly Task"},
      {"id": 2, "key": "monthly", "name": "If It's Monthly Task"}
    ]);

    _taskDayList.sink.add([
      CommonList(id: 1, name: "Monday"),
      CommonList(id: 2, name: "Tuesday"),
      CommonList(id: 3, name: "Wednesday"),
      CommonList(id: 4, name: "Thursday"),
      CommonList(id: 5, name: "Friday"),
      CommonList(id: 6, name: "Saturday"),
      CommonList(id: 7, name: "Sunday"),
    ]);

    final response = await _employeeListUseCase();
    response.fold((_) => {}, (_) {
      if (_.employeeList!.isNotEmpty) {
        _assignList.sink.add(_.employeeList ?? []);
        _leadList.sink.add(_.employeeList ?? []);
      } else {
        _assignList.sink.add([]);
        _leadList.sink.add([]);
      }
    });
  }

  void lead(params) {
    _leadListInit.sink.add(CommonList(id: params.value, name: params.name));
  }

  void assignTo(params) {
    _assignListInit.sink.add(CommonList(id: params.value, name: params.name));
  }

  void taskType(params) {
    _taskTypeInit.sink.add(params);
  }

  void taskDay(params) {
    _taskDayListInit.sink.add(CommonList(id: params.value, name: params.name));
  }

  void selectedStartTime(BuildContext context, DateTime date, TimeOfDay time) {
    _startTime.sink.add(time);
    _startDate.sink.add(date);
    _startDateTime.sink
        .add(DateTime(date.year, date.month, date.day, time.hour, time.minute));
    _selectStartTime.sink.add(
        "${DateFormat('yyyy-MM-dd').format(date)} ${time.hour}:${time.minute}");
  }

  void selectedToTime(BuildContext context, DateTime date, TimeOfDay time) {
    _endTime.sink.add(time);
    _endDate.sink.add(date);
    _endDateTime.sink
        .add(DateTime(date.year, date.month, date.day, time.hour, time.minute));
    _selectEndTime.sink.add(
        "${DateFormat('yyyy-MM-dd').format(date)} ${time.hour}:${time.minute}");
  }

  Future<void> onSubmit(BuildContext context) async {
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
      "task_method": "others",
      "task": taskController.text,
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
      "lead": _leadListInit.valueOrNull?.id ?? 0,
      "task_type": _taskTypeInit.valueOrNull ?? '',
      "task_day": _taskTypeInit.valueOrNull == "weekly"
          ? _taskDayListInit.valueOrNull?.name ?? ''
          : "",
      "description": descriptionController.text,
    };

    BlocProvider.of<TaskCrudBloc>(context)
        .add(CreateSupportTaskEvent(body: body));
  }
}
