part of 'food_attendance_bloc.dart';

abstract class FoodAttendanceState extends Equatable {
  const FoodAttendanceState();

  @override
  List<Object> get props => [];
}

class FoodAttendanceInitial extends FoodAttendanceState {
  const FoodAttendanceInitial();
}

class UpdateFoodAttendanceLoading extends FoodAttendanceState {
  const UpdateFoodAttendanceLoading();
}

class UpdateFoodAttendanceSuccess extends FoodAttendanceState {
  const UpdateFoodAttendanceSuccess();
}

class UpdateFoodAttendanceFailed extends FoodAttendanceState {
  const UpdateFoodAttendanceFailed(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}
