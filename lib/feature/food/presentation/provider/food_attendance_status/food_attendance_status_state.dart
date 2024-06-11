part of 'food_attendance_status_cubit.dart';

abstract class FoodAttendanceStatusState extends Equatable {
  const FoodAttendanceStatusState();
  @override
  List<Object> get props => [];
}

class FoodAttendanceStatusInitial extends FoodAttendanceStatusState {
  const FoodAttendanceStatusInitial();
}

class FoodAttendanceStatusLoading extends FoodAttendanceStatusState {
  const FoodAttendanceStatusLoading();
}

class FoodAttendanceStatusLoaded extends FoodAttendanceStatusState {
  final FoodAttendanceResponse foodAttendanceResponse;
  const FoodAttendanceStatusLoaded({required this.foodAttendanceResponse});

  @override
  List<Object> get props => [foodAttendanceResponse];
}

class FoodAttendanceStatusFailed extends FoodAttendanceStatusState {
  const FoodAttendanceStatusFailed(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}
