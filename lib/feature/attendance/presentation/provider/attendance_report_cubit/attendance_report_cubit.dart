import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../attendance.dart';

part 'attendance_report_state.dart';

class AttendanceReportCubit extends Cubit<AttendanceReportState> {
  AttendanceReportCubit(
      {required GetAttendanceUserList getAttendanceUserList,
      required AttendanceReportList attendanceReportList})
      : _getAttendanceUserList = getAttendanceUserList,
        _attendanceReportList = attendanceReportList,
        super(AttendanceReportInitial());

  final GetAttendanceUserList _getAttendanceUserList;
  final AttendanceReportList _attendanceReportList;

  Future<void> grtAttendanceUserList(String date, String id) async {
    emit(const AttendanceReportLoading());
    final attendanceResponse = await _getAttendanceUserList(
        ReportListRequestParams(date: date, id: id));

    attendanceResponse.fold(
      (failure) => emit(AttendanceReportFailed(message: failure.message)),
      (attendance) => emit(AttendanceReportLoaded(attendanceList: attendance)),
    );
  }

  Future<void> grtAttendanceReportList(String fromDate, String toDate) async {
    emit(const AttendanceReportLoading());
    final attendanceResponse = await _attendanceReportList(
        AttendanceReportParams(fromDate: fromDate, toDate: toDate));

    attendanceResponse.fold(
      (failure) => emit(AttendanceReportFailed(message: failure.message)),
      (attendance) =>
          emit(AttendanceReportLogLoaded(attendanceList: attendance)),
    );
  }
}
