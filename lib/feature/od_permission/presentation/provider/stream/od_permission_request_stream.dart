import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/core.dart';
import '../../../../feature.dart';

class ODPermissionRequestStream {
  ODPermissionRequestStream(
      {required ShiftTimeUseCase shiftTimeUseCase,
      required ODBalanceUseCase oDBalanceUseCase,
      required GetMisspunchForwardList getMisspunchForwardList,
      required RequestToUseCase requestToUseCase})
      : _shiftTimeUseCase = shiftTimeUseCase,
        _oDBalanceUseCase = oDBalanceUseCase,
        _getMisspunchForwardList = getMisspunchForwardList,
        _requestToUseCase = requestToUseCase;

  final GetMisspunchForwardList _getMisspunchForwardList;
  final ShiftTimeUseCase _shiftTimeUseCase;
  final ODBalanceUseCase _oDBalanceUseCase;
  final RequestToUseCase _requestToUseCase;

  late TextEditingController statusController = TextEditingController();

  final reasonController = TextEditingController();

  final _date = BehaviorSubject<DateTime?>();
  final _selectDate = BehaviorSubject<String>();

  final _fromDate = BehaviorSubject<DateTime?>();
  final _toDate = BehaviorSubject<DateTime?>();

  final _fromTime = BehaviorSubject<TimeOfDay?>();
  final _toTime = BehaviorSubject<TimeOfDay?>();

  final _selectFromTime = BehaviorSubject<String>();
  final _selectToTime = BehaviorSubject<String>();

  final _requestList = BehaviorSubject<List<CommonList>>.seeded([]);
  final _forwardToList = BehaviorSubject<List<CommonList>>.seeded([]);
  final _shiftTimeList = BehaviorSubject<List<CommonList>>.seeded([]);

  final _requestListInit = BehaviorSubject<CommonList>();
  final _forwardToListInit = BehaviorSubject<CommonList>();
  final _shiftTimeListInit = BehaviorSubject<CommonList>();

  final _forwardSubject = BehaviorSubject<String>.seeded('');
  final _forwardIdSubject = BehaviorSubject<String>.seeded('');

  final _balanceOdSubject = BehaviorSubject<dynamic>.seeded(0);

  Stream<String> get forwardSubject => _forwardSubject.stream;

  Stream<dynamic> get balanceOdSubject => _balanceOdSubject.stream;

  Stream<List<CommonList>> get requestList => _requestList.stream;

  Stream<List<CommonList>> get forwardToList => _forwardToList.stream;

  Stream<List<CommonList>> get shiftTimeList => _shiftTimeList.stream;

  ValueStream<CommonList> get requestListInit => _requestListInit.stream;

  ValueStream<CommonList> get forwardToListInit => _forwardToListInit.stream;

  ValueStream<CommonList> get shiftTimeListInit => _shiftTimeListInit.stream;

  ValueStream<DateTime?> get date => _date.stream;

  ValueStream<String> get selectDate => _selectDate.stream;

  ValueStream<DateTime?> get fromDate => _fromDate.stream;

  ValueStream<DateTime?> get toDate => _toDate.stream;

  ValueStream<TimeOfDay?> get fromTime => _fromTime.stream;

  ValueStream<TimeOfDay?> get toTime => _toTime.stream;

  ValueStream<String> get selectFromTime => _selectFromTime.stream;

  ValueStream<String> get selectToTime => _selectToTime.stream;

  Future<void> fetchInitialCallBack() async {
    statusController = TextEditingController(text: "INITIATED");

    final requestResponse = await _requestToUseCase();
    requestResponse.fold(
      (l) => {_requestList.sink.add([])},
      (request) {
        if (request.request!.isNotEmpty) {
          _requestList.sink.add(request.request ?? []);
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

    final shiftTimeResponse = await _shiftTimeUseCase();
    shiftTimeResponse.fold(
      (l) => {_shiftTimeList.sink.add([])},
      (forward) {
        if (forward.shiftTime!.isNotEmpty) {
          _shiftTimeList.sink.add(forward.shiftTime ?? []);
        } else {
          _shiftTimeList.sink.add([]);
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
          _forwardIdSubject.sink.add(forward.empName ?? "");
          _forwardToList.sink.add(forward.forwardList ?? []);
        } else {
          _forwardToList.sink.add([]);
        }
      },
    );
  }

  Future<void> fetchBalanceOdCallBack(type) async {
    final oDBalanceResponse =
        await _oDBalanceUseCase(ODBalanceParams(type: type));
    oDBalanceResponse.fold(
      (_) => {_balanceOdSubject.sink.add(0)},
      (__) {
        if (__.message != null) {
          _balanceOdSubject.sink.add(__.message ?? 0);
        } else {
          _balanceOdSubject.sink.add(0);
        }
      },
    );
  }

  void request(params) {
    _requestListInit.sink.add(CommonList(id: params.value, name: params.name));
    fetchBalanceOdCallBack(_requestListInit.valueOrNull!.id);
  }

  void forward(params) {
    _forwardToListInit.sink
        .add(CommonList(id: params.value, name: params.name));
  }

  void shiftTime(params) {
    _shiftTimeListInit.sink
        .add(CommonList(id: params.value, name: params.name));
  }

  void selectedDate(DateTime date) {
    _date.sink.add(date);
    _selectDate.sink.add(DateFormat('yyyy-MM-dd').format(date));
  }

  void selectedFromTime(BuildContext context, DateTime date, TimeOfDay time) {
    _fromTime.sink.add(time);
    _fromDate.sink.add(date);
    _selectFromTime.sink.add(
        "${DateFormat('yyyy-MM-dd').format(date)} ${time.hour}:${time.minute}");
  }

  void selectedToTime(BuildContext context, DateTime date, TimeOfDay time) {
    _toTime.sink.add(time);
    _toDate.sink.add(date);
    _selectToTime.sink.add(
        "${DateFormat('yyyy-MM-dd').format(date)} ${time.hour}:${time.minute}");
  }

  Future<void> onSubmit(BuildContext context) async {
    Logger().i("Submit Button Click");

    final minutes = PickDateTime.calculateTimeInterval(_fromDate.valueOrNull,
        _fromTime.valueOrNull, _toDate.valueOrNull, _toTime.valueOrNull);

    final latitude = SharedPrefs.instance.getDouble(AppKeys.currentLatitude);
    final longitude = SharedPrefs.instance.getDouble(AppKeys.currentLongitude);
    final geoAddress = SharedPrefs.instance.getString(AppKeys.currentAddress);

    final body = {
      "request_id": _requestListInit.valueOrNull!.id,
      "shift_id": _shiftTimeListInit.valueOrNull!.id,
      "date": _selectDate.valueOrNull,
      "in_time": _fromTime.valueOrNull == null
          ? ''
          : _selectFromTime.valueOrNull ?? '',
      "out_time":
          _toTime.valueOrNull == null ? '' : _selectToTime.valueOrNull ?? '',
      "company_id": SharedPrefs().companyId(),
      "number_minitus": minutes,
      "reason": reasonController.text,
      "status": statusController.text,
      "forward_to": _forwardIdSubject.value,
      'geo_location': {
        'latitude': latitude,
        'longitude': longitude,
        'geo_address': geoAddress,
      },
    };

    Logger().i("Submit: $body");

    BlocProvider.of<PermissionCrudBloc>(context)
        .add(PermissionSubmitEvent(body: body));
  }
}
