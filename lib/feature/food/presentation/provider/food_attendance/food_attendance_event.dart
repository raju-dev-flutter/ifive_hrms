part of 'food_attendance_bloc.dart';

abstract class FoodAttendanceEvent extends Equatable {
  const FoodAttendanceEvent();

  @override
  List<Object> get props => [];
}

class UpdateFoodAttendanceEvent extends FoodAttendanceEvent {
  final String status;

  const UpdateFoodAttendanceEvent({required this.status});

  @override
  List<Object> get props => [status];
}
