part of 'food_attendance_report_cubit.dart';

abstract class FoodAttendanceReportState extends Equatable {
  const FoodAttendanceReportState();

  @override
  List<Object> get props => [];
}

class FoodAttendanceReportInitial extends FoodAttendanceReportState {}

class FoodAttendanceReportLoading extends FoodAttendanceReportState {
  const FoodAttendanceReportLoading();
}

class FoodAttendanceReportLoaded extends FoodAttendanceReportState {
  final FoodAttendanceListModel attendanceList;

  const FoodAttendanceReportLoaded({required this.attendanceList});

  @override
  List<Object> get props => [attendanceList];
}

class FoodAttendanceReportFailed extends FoodAttendanceReportState {
  final String message;

  const FoodAttendanceReportFailed({required this.message});

  @override
  List<Object> get props => [message];
}
