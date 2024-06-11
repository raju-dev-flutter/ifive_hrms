import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/core.dart';
import '../../../misspunch.dart';

class MissPunchRequestStream {
  MissPunchRequestStream(
      {required GetMisspunchForwardList getMisspunchForwardList,
      required GetMisspunchRequestList getMisspunchRequestList})
      : _getMisspunchForwardList = getMisspunchForwardList,
        _getMisspunchRequestList = getMisspunchRequestList;

  final GetMisspunchForwardList _getMisspunchForwardList;
  final GetMisspunchRequestList _getMisspunchRequestList;

  late TextEditingController statusController = TextEditingController();

  final reasonController = TextEditingController();

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

  final _requestList = BehaviorSubject<List<CommonList>>.seeded([]);
  final _forwardToList = BehaviorSubject<List<CommonList>>.seeded([]);

  final _requestListInit = BehaviorSubject<CommonList>();
  final _forwardToListInit = BehaviorSubject<CommonList>();

  final _forwardSubject = BehaviorSubject<String>.seeded('');
  final _forwardIdSubject = BehaviorSubject<String>.seeded('');

  Stream<String> get forwardSubject => _forwardSubject.stream;
  Stream<String> get forwardIdSubject => _forwardIdSubject.stream;

  Stream<List<CommonList>> get requestList => _requestList.stream;
  Stream<List<CommonList>> get forwardToList => _forwardToList.stream;

  ValueStream<CommonList> get requestListInit => _requestListInit.stream;
  ValueStream<CommonList> get forwardToListInit => _forwardToListInit.stream;

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
    statusController = TextEditingController(text: "INITIATED");

    final requestResponse = await _getMisspunchRequestList();
    requestResponse.fold(
      (l) => {_requestList.sink.add([])},
      (request) {
        if (request.misspunch!.isNotEmpty) {
          _requestList.sink.add(request.misspunch ?? []);
        } else {
          _requestList.sink.add([]);
        }
      },
    );

    final leaveForwardResponse = await _getMisspunchForwardList();
    leaveForwardResponse.fold(
      (l) => {_forwardToList.sink.add([])},
      (forward) {
        if (forward.forwardList!.isNotEmpty) {
          _forwardSubject.sink.add(forward.empName ?? "");
          _forwardIdSubject.sink.add(forward.id ?? "");
          _forwardToList.sink.add(forward.forwardList ?? []);
        } else {
          _forwardToList.sink.add([]);
        }
      },
    );
  }

  Future<void> fetchForwardCallBack() async {
    Logger().i("fetchForwardCallBack");
    final leaveForwardResponse = await _getMisspunchForwardList();
    leaveForwardResponse.fold(
      (l) => {_forwardToList.sink.add([])},
      (forward) {
        if (forward.forwardList!.isNotEmpty) {
          _forwardSubject.sink.add(forward.empName ?? "");
          _forwardIdSubject.sink.add(forward.id ?? "");
          _forwardToList.sink.add(forward.forwardList ?? []);
        } else {
          _forwardToList.sink.add([]);
        }
      },
    );
  }

  void request(params) {
    _requestListInit.sink.add(CommonList(id: params.value, name: params.name));
  }

  void forward(params) {
    _forwardToListInit.sink
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

  void selectedFromDate(DateTime date) {
    _fromDate.sink.add(date);
    _selectFromDate.sink.add(DateFormat('yyyy-MM-dd').format(date));
    _date.sink.add(null);
    _selectDate.sink.add('');
  }

  void selectedToDate(DateTime date) {
    _toDate.sink.add(date);
    _selectToDate.sink.add(DateFormat('yyyy-MM-dd').format(date));
    _date.sink.add(null);
    _selectDate.sink.add('');
  }

  void selectedTime(BuildContext context, TimeOfDay time) {
    _time.sink.add(time);
    _selectTime.sink.add("${time.hour}:${time.minute}");
    _fromTime.sink.add(null);
    _toTime.sink.add(null);
    _selectFromTime.sink.add('');
    _selectToTime.sink.add('');
  }

  void selectedFromTime(BuildContext context, TimeOfDay time) {
    _fromTime.sink.add(time);
    _selectFromTime.sink.add("${time.hour}:${time.minute}");
    _time.sink.add(null);
    _selectTime.sink.add('');
  }

  void selectedToTime(BuildContext context, TimeOfDay time) {
    _toTime.sink.add(time);
    _selectToTime.sink.add("${time.hour}:${time.minute}");
    _time.sink.add(null);
    _selectTime.sink.add('');
  }

  Future<void> onSubmit(BuildContext context) async {
    Logger().i("Submit Button Click");

    final latitude = SharedPrefs.instance.getDouble(AppKeys.currentLatitude);
    final longitude = SharedPrefs.instance.getDouble(AppKeys.currentLongitude);
    final geoAddress = SharedPrefs.instance.getString(AppKeys.currentAddress);

    final body = {
      'company_id': SharedPrefs().companyId(),
      'status': statusController.text,
      'forwarded_id': _forwardIdSubject.value,
      'misspunch': "${_requestListInit.valueOrNull?.id ?? ''}",
      'date': _date.valueOrNull == null ? "" : _selectDate.valueOrNull ?? '',
      'in_out': _fromDate.valueOrNull == null
          ? ""
          : _selectFromDate.valueOrNull ?? '',
      'out_in':
          _toDate.valueOrNull == null ? "" : _selectToDate.valueOrNull ?? '',
      'time': _time.valueOrNull == null ? '' : _selectTime.valueOrNull ?? '',
      'in_time': _fromTime.valueOrNull == null
          ? ''
          : _selectFromTime.valueOrNull ?? '',
      'out_time':
          _toTime.valueOrNull == null ? '' : _selectToTime.valueOrNull ?? '',
      'reason': reasonController.text,
      'reason1': '',
      'shift': 0,
      'version': 0,
      'geo_location': {
        'latitude': latitude,
        'longitude': longitude,
        'geo_address': geoAddress,
      },
    };

    Logger().i("Submit: $body");

    BlocProvider.of<MisspunchCrudBloc>(context)
        .add(MisspunchRequestSaveEven(body: body));
  }
}
