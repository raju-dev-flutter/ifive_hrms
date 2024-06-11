import 'package:flutter/material.dart';
import 'package:ifive_hrms/feature/calendar/domain/domain.dart';
import 'package:rxdart/rxdart.dart';

import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../calendar.dart';

class CalendarStream {
  CalendarStream(
      {required HolidayHistoryUseCase holidayHistoryUseCase,
      required LeavesHistoryUseCase leavesHistoryUseCase,
      required PresentHistoryUseCase presentHistoryUseCase,
      required AbsentHistoryUseCase absentHistoryUseCase})
      : _holidayHistoryUseCase = holidayHistoryUseCase,
        _leavesHistoryUseCase = leavesHistoryUseCase,
        _presentHistoryUseCase = presentHistoryUseCase,
        _absentHistoryUseCase = absentHistoryUseCase;

  final HolidayHistoryUseCase _holidayHistoryUseCase;
  final LeavesHistoryUseCase _leavesHistoryUseCase;
  final PresentHistoryUseCase _presentHistoryUseCase;
  final AbsentHistoryUseCase _absentHistoryUseCase;

  final _appointmentsList = BehaviorSubject<List<Appointment>>.seeded([]);

  Stream<List<Appointment>> get appointmentsList => _appointmentsList;

  Future<List<Appointment>> fetchInitialCallBack(
      String fromDate, String toDate) async {
    List<Appointment> appointments = <Appointment>[];

    final holidayResponse = await _holidayHistoryUseCase.call();
    holidayResponse.fold(
      (l) => null,
      (responses) {
        for (var response in responses.holidayHistory!) {
          DateTime dateTime = DateTime.parse(response.date!);
          appointments.add(Appointment(
            startTime: dateTime,
            endTime: dateTime,
            subject: response.holidayName ?? "",
            color: const Color(0xFFD444F1),
            startTimeZone: '',
            endTimeZone: '',
            isAllDay: true,
          ));
          _appointmentsList.sink.add(appointments);
        }
      },
    );

    final leavesResponse = await _leavesHistoryUseCase.call();
    leavesResponse.fold(
      (l) => null,
      (responses) {
        for (var response in responses.leavesHistory!) {
          DateTime startTime = DateTime.parse(response.startDate!);
          DateTime endTime = DateTime.parse(response.startDate!);
          appointments.add(Appointment(
            startTime: startTime,
            endTime: endTime,
            subject: response.leaveReason ?? "",
            color: const Color(0xFF22CCEE),
            startTimeZone: '',
            endTimeZone: '',
            isAllDay: true,
          ));
          _appointmentsList.sink.add(appointments);
        }
      },
    );

    final presentResponse = await _presentHistoryUseCase(
        PresentRequestParams(fromDate: fromDate, toDate: toDate));
    presentResponse.fold(
      (l) => null,
      (responses) {
        for (var response in responses.presentHistory!) {
          DateTime startTime = DateTime.parse(response.start!);
          DateTime endTime = DateTime.parse(response.start!);
          appointments.add(Appointment(
            startTime: startTime,
            endTime: endTime,
            subject: response.title ?? "",
            color: const Color(0xFF66C61C),
            startTimeZone: '',
            endTimeZone: '',
            isAllDay: true,
          ));
          _appointmentsList.sink.add(appointments);
        }
        // return appointments;
      },
    );

    final absentResponse = await _absentHistoryUseCase(
        AbsentRequestParams(fromDate: fromDate, toDate: toDate));
    absentResponse.fold(
      (l) => null,
      (responses) {
        for (var response in responses.absentHistory!) {
          DateTime startTime = DateTime.parse(response.start!);
          DateTime endTime = DateTime.parse(response.start!);
          appointments.add(Appointment(
            startTime: startTime,
            endTime: endTime,
            subject: response.title ?? "",
            color: const Color(0XFFD92D20),
            startTimeZone: '',
            endTimeZone: '',
            isAllDay: true,
          ));
          _appointmentsList.sink.add(appointments);
        }
        // return appointments;
      },
    );

    return appointments;
  }
}
