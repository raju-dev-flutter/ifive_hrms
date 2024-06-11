part of 'attendance_status_cubit.dart';

abstract class AttendanceStatusState extends Equatable {
  const AttendanceStatusState();
  @override
  List<Object> get props => [];
}

class AttendanceStatusInitial extends AttendanceStatusState {
  const AttendanceStatusInitial();
}

class AttendanceStatusLoading extends AttendanceStatusState {
  const AttendanceStatusLoading();
}

class AttendanceStatusLoaded extends AttendanceStatusState {
  final AttendanceResponse attendanceResponse;

  const AttendanceStatusLoaded({required this.attendanceResponse});

  @override
  List<Object> get props => [attendanceResponse];
}

class AttendanceStatusFailed extends AttendanceStatusState {
  final String message;

  const AttendanceStatusFailed({required this.message});

  @override
  List<Object> get props => [];
}
