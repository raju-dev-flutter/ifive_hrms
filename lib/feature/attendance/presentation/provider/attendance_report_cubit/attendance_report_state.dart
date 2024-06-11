part of 'attendance_report_cubit.dart';

abstract class AttendanceReportState extends Equatable {
  const AttendanceReportState();

  @override
  List<Object> get props => [];
}

class AttendanceReportInitial extends AttendanceReportState {}

class AttendanceReportLoading extends AttendanceReportState {
  const AttendanceReportLoading();
}

class AttendanceReportLoaded extends AttendanceReportState {
  final OverAllAttendanceModel attendanceList;

  const AttendanceReportLoaded({required this.attendanceList});

  @override
  List<Object> get props => [attendanceList];
}

class AttendanceReportLogLoaded extends AttendanceReportState {
  final AttendanceReportModel attendanceList;

  const AttendanceReportLogLoaded({required this.attendanceList});

  @override
  List<Object> get props => [attendanceList];
}

class AttendanceReportFailed extends AttendanceReportState {
  final String message;

  const AttendanceReportFailed({required this.message});

  @override
  List<Object> get props => [message];
}
