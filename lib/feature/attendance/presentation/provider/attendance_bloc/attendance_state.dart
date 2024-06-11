part of 'attendance_bloc.dart';

abstract class AttendanceState extends Equatable {
  const AttendanceState();
  @override
  List<Object> get props => [];
}

class AttendanceInitial extends AttendanceState {}

class AttendanceLoading extends AttendanceState {
  const AttendanceLoading();
}

class AttendanceLoginLoading extends AttendanceState {
  const AttendanceLoginLoading();
}

class AttendanceLogoutLoading extends AttendanceState {
  const AttendanceLogoutLoading();
}

class AttendanceSuccess extends AttendanceState {
  const AttendanceSuccess({required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}

class AttendanceFailed extends AttendanceState {
  const AttendanceFailed(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}
