import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../attendance/attendance.dart';
import '../../../dashboard.dart';

part 'attendance_status_state.dart';

class AttendanceStatusCubit extends Cubit<AttendanceStatusState> {
  AttendanceStatusCubit({required GetAttendanceStatus attendanceStatus})
      : _attendanceStatus = attendanceStatus,
        super(const AttendanceStatusInitial());

  final GetAttendanceStatus _attendanceStatus;

  void getAttendanceStatus(String token) async {
    emit(const AttendanceStatusLoading());
    final response =
        await _attendanceStatus(AttendanceStatusParams(token: token));

    response.fold(
      (failure) => emit(AttendanceStatusFailed(message: failure.errorMessage)),
      (status) => emit(AttendanceStatusLoaded(attendanceResponse: status)),
    );
  }
}
