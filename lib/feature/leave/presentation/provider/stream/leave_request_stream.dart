import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/core.dart';
import '../../../leave.dart';

class LeaveRequestStream {
  LeaveRequestStream(
      {required LeaveForward leaveForward,
      required LeaveType leaveType,
      required LeaveMode leaveMode,
      required RemainingLeave remainingLeave,
      required LeaveBalanceCalculator leaveBalanceCalculator})
      : _leaveForward = leaveForward,
        _leaveType = leaveType,
        _leaveMode = leaveMode,
        _remainingLeave = remainingLeave,
        _leaveBalanceCalculator = leaveBalanceCalculator;

  final LeaveForward _leaveForward;
  final LeaveType _leaveType;
  final LeaveMode _leaveMode;

  final RemainingLeave _remainingLeave;
  final LeaveBalanceCalculator _leaveBalanceCalculator;

  late TextEditingController statusController = TextEditingController();

  final reasonController = TextEditingController();

  final _leaveTypeList = BehaviorSubject<List<CommonList>>.seeded([]);
  final _leaveModeList = BehaviorSubject<List<CommonList>>.seeded([]);
  final _leaveForwardList = BehaviorSubject<List<CommonList>>.seeded([]);

  final _leaveTypeListInit = BehaviorSubject<CommonList>();
  final _leaveModeListInit = BehaviorSubject<CommonList>();
  final _leaveForwardListInit = BehaviorSubject<CommonList>();

  final _leaveForwardSubject = BehaviorSubject<String>.seeded('');
  final _leaveForwardIdSubject = BehaviorSubject<String>.seeded('');

  final _leaveRemaining = BehaviorSubject<String>();
  final _calculateLeaveBalance = BehaviorSubject<LeaveBalanceModel>();

  final _date = BehaviorSubject<DateTime?>();
  final _fromDate = BehaviorSubject<DateTime?>();
  final _toDate = BehaviorSubject<DateTime?>();

  final _selectDate = BehaviorSubject<String>();
  final _selectFromDate = BehaviorSubject<String>();
  final _selectToDate = BehaviorSubject<String>();

  final _time = BehaviorSubject<TimeOfDay?>();
  final _fromTime = BehaviorSubject<TimeOfDay?>();
  final _toTime = BehaviorSubject<TimeOfDay?>();

  final _selectTime = BehaviorSubject<String>();
  final _selectFromTime = BehaviorSubject<String>();
  final _selectToTime = BehaviorSubject<String>();

  Stream<List<CommonList>> get leaveTypeList => _leaveTypeList.stream;

  Stream<List<CommonList>> get leaveModeList => _leaveModeList.stream;

  ValueStream<String> get leaveForwardSubject => _leaveForwardSubject.stream;
  ValueStream<String> get leaveForwardIdSubject =>
      _leaveForwardIdSubject.stream;

  Stream<List<CommonList>> get leaveForwardList => _leaveForwardList.stream;

  ValueStream<CommonList> get leaveTypeListInit => _leaveTypeListInit.stream;

  ValueStream<CommonList> get leaveModeListInit => _leaveModeListInit.stream;

  ValueStream<CommonList> get leaveForwardListInit =>
      _leaveForwardListInit.stream;

  Stream<String> get leaveRemaining => _leaveRemaining.stream;

  Stream<LeaveBalanceModel> get calculateLeaveBalance =>
      _calculateLeaveBalance.stream;

  ValueStream<String> get selectDate => _selectDate.stream;

  ValueStream<String> get selectFromDate => _selectFromDate.stream;

  ValueStream<String> get selectToDate => _selectToDate.stream;

  ValueStream<DateTime?> get date => _date.stream;

  ValueStream<DateTime?> get fromDate => _fromDate.stream;

  ValueStream<DateTime?> get toDate => _toDate.stream;

  ValueStream<String> get selectTime => _selectTime.stream;

  ValueStream<String> get selectFromTime => _selectFromTime.stream;

  ValueStream<String> get selectToTime => _selectToTime.stream;

  ValueStream<TimeOfDay?> get time => _time.stream;

  ValueStream<TimeOfDay?> get fromTime => _fromTime.stream;

  ValueStream<TimeOfDay?> get toTime => _toTime.stream;

  Future<void> fetchInitialCallBack() async {
    Logger().i("Leave Request Initiated");
    statusController = TextEditingController(text: "INITIATED");

    final leaveTypeResponse = await _leaveType();
    leaveTypeResponse.fold(
      (l) => {_leaveTypeList.sink.add([])},
      (type) {
        if (type.leaveType!.isNotEmpty) {
          _leaveTypeList.sink.add(type.leaveType ?? []);
        } else {
          _leaveTypeList.sink.add([]);
        }
      },
    );
  }

  Future<void> fetchRemainingLeaveCallBack(type) async {
    final leaveBalanceResponse =
        await _remainingLeave(RemainingLeaveParams(type: type));
    leaveBalanceResponse.fold(
      (l) => {_leaveModeList.sink.add([])},
      (remaining) {
        _leaveRemaining.sink.add((remaining.remainingDays ?? 0).toString());
        fetchForwardCallBack(type, remaining.remainingDays ?? 0);
      },
    );
  }

  Future<void> fetchForwardCallBack(type, noOfDays) async {
    Logger().i("fetchForwardCallBack");
    final leaveForwardResponse = await _leaveForward(
        LeaveForwardRequestParams(type: type, noOfDays: noOfDays));
    leaveForwardResponse.fold(
      (l) => {_leaveForwardList.sink.add([])},
      (forward) {
        if (forward.employeeName!.isNotEmpty) {
          _leaveForwardSubject.sink.add(forward.empName ?? "");
          _leaveForwardIdSubject.sink.add(forward.id ?? "");
          _leaveForwardList.sink.add(forward.employeeName ?? []);
        } else {
          _leaveForwardList.sink.add([]);
        }
      },
    );
  }

  void type(params, BuildContext context) {
    _leaveTypeListInit.sink
        .add(CommonList(id: params.value, name: params.name));
    // _leaveModeListInit.add(CommonList());
    // _leaveModeList.sink.add([]);
    fetchRemainingLeaveCallBack(_leaveTypeListInit.valueOrNull?.id);
    updateLeaveMode(_leaveTypeListInit.valueOrNull?.id);
    calculatingLeaveBalance(
        _selectFromDate.valueOrNull, _selectToDate.valueOrNull, context);
  }

  void updateLeaveMode(type) async {
    final leaveModeResponse = await _leaveMode(LeaveModeParams(type: type));
    leaveModeResponse.fold(
      (l) => {_leaveModeList.sink.add([])},
      (mode) {
        if (mode.leaveMode!.isNotEmpty) {
          _leaveModeList.sink.add(mode.leaveMode ?? []);
        } else {
          _leaveModeList.sink.add([]);
        }
      },
    );
  }

  void mode(params, BuildContext context) {
    _leaveModeListInit.sink
        .add(CommonList(id: params.value, name: params.name));
    calculatingLeaveBalance(
        _selectFromDate.valueOrNull, _selectToDate.valueOrNull, context);
  }

  void forward(params) {
    _leaveForwardListInit.sink
        .add(CommonList(id: params.value, name: params.name));
  }

  void selectedDate(DateTime date) {
    _date.sink.add(date);
    _selectDate.sink.add(DateFormat('yyyy-MM-dd').format(date));
    _fromDate.sink.add(null);
    _toDate.sink.add(null);
    _selectFromDate.sink.add('');
    _selectToDate.sink.add('');
  }

  void selectedFromDate(DateTime date, BuildContext context) {
    _fromDate.sink.add(date);
    _selectFromDate.sink.add(DateFormat('yyyy-MM-dd').format(date));
    calculatingLeaveBalance(DateFormat('yyyy-MM-dd').format(date),
        _selectToDate.valueOrNull, context);
    _date.sink.add(null);
    _selectDate.sink.add('');
  }

  void selectedToDate(DateTime date, BuildContext context) {
    _toDate.sink.add(date);
    _selectToDate.sink.add(DateFormat('yyyy-MM-dd').format(date));
    calculatingLeaveBalance(_selectFromDate.valueOrNull,
        DateFormat('yyyy-MM-dd').format(date), context);
    _date.sink.add(null);
    _selectDate.sink.add('');
  }

  void selectedTime(BuildContext context, TimeOfDay time) {
    _time.sink.add(time);
    _selectTime.sink.add(PickDateTime.format12Time(time));
    _fromTime.sink.add(null);
    _toTime.sink.add(null);
    _selectFromTime.sink.add('');
    _selectToTime.sink.add('');
  }

  void selectedFromTime(BuildContext context, TimeOfDay time) {
    _fromTime.sink.add(time);
    _selectFromTime.sink.add(PickDateTime.format12Time(time));
    _time.sink.add(null);
    _selectTime.sink.add('');
  }

  void selectedToTime(BuildContext context, TimeOfDay time) {
    _toTime.sink.add(time);
    _selectToTime.sink.add(PickDateTime.format12Time(time));
    _time.sink.add(null);
    _selectTime.sink.add('');
  }

  Future<void> calculatingLeaveBalance(from, to, context) async {
    Logger().i(_leaveModeListInit.valueOrNull?.id);
    final leaveResponse =
        await _leaveBalanceCalculator(LeaveBalanceCalculatorParams(body: {
      'leave_type': _leaveTypeListInit.valueOrNull?.id ?? 0,
      'leave_mode': _leaveModeListInit.valueOrNull?.id ?? 0,
      'from_date': from,
      'to_date': to
    }));
    leaveResponse.fold(
      (l) => {_calculateLeaveBalance.sink.add(LeaveBalanceModel())},
      (calculate) {
        _calculateLeaveBalance.sink.add(calculate);
        if (calculate.message != "SUCCESS") {
          AppAlerts.displayWarningAlert(
              context, "Privilege Leave", calculate.message ?? '');
        }
      },
    );
  }

  Future<void> onSubmit(BuildContext context) async {
    Logger().i("Submit Button Click");

    // final isCheck = _leaveModeListInit.valueOrNull?.name == "HALF DAY" &&
    //     _leaveModeListInit.valueOrNull?.name != null;

    // final isDay =
    //     PickDateTime.noOfDays(_fromDate.valueOrNull, _toDate.valueOrNull);

    // double isLength = isCheck
    //     ? isDay == 1
    //         ? 0.5
    //         : isDay.toDouble()
    //     : isDay.toDouble();

    // final noOfDay =
    //     isLength == 0.5 ? isLength.toString() : isLength.toInt().toString();

    final companyId = SharedPrefs().companyId();

    final latitude = SharedPrefs.instance.getDouble(AppKeys.currentLatitude);
    final longitude = SharedPrefs.instance.getDouble(AppKeys.currentLongitude);
    final geoAddress = SharedPrefs.instance.getString(AppKeys.currentAddress);

    final body = {
      "company_id": companyId,
      "leave_type": _leaveTypeListInit.valueOrNull?.id ?? 0,
      "leave_mode": _leaveModeListInit.valueOrNull?.id ?? 0,
      "no_of_days": _calculateLeaveBalance.valueOrNull?.totalLeave ?? 0,
      "leave_status": statusController.text,
      "forwarded_to": _leaveForwardIdSubject.valueOrNull,
      "request_date": _selectFromDate.valueOrNull,
      "end_date": _selectToDate.valueOrNull,
      'geo_location': {
        'latitude': latitude,
        'longitude': longitude,
        'geo_address': geoAddress,
      },
      "start_time": "",
      "end_time": "",
      "combo_date": "",
      "no_of_hrs": "",
      "level": "",
      "reason": reasonController.text,
    };

    Logger().t("Submit Body: $body");

    BlocProvider.of<LeaveCrudBloc>(context)
        .add(CreateLeaveRequestEvent(body: body));
  }
}
