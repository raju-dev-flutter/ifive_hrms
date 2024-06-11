import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../feature.dart';

part 'food_attendance_event.dart';
part 'food_attendance_state.dart';

class FoodAttendanceBloc
    extends Bloc<FoodAttendanceEvent, FoodAttendanceState> {
  FoodAttendanceBloc({required UpdateFoodAttendance updateFoodAttendance})
      : _updateFoodAttendance = updateFoodAttendance,
        super(initialState()) {
    on<UpdateFoodAttendanceEvent>(_updateFoodAttendanceEvent);
  }
  final UpdateFoodAttendance _updateFoodAttendance;

  static initialState() => const FoodAttendanceInitial();

  void _updateFoodAttendanceEvent(UpdateFoodAttendanceEvent event,
      Emitter<FoodAttendanceState> emit) async {
    emit(const UpdateFoodAttendanceLoading());
    final foodAttendanceResponse = await _updateFoodAttendance(
        UpdateFoodRequestParams(status: event.status));

    foodAttendanceResponse.fold(
      (failure) => emit(UpdateFoodAttendanceFailed(failure.message)),
      (foodResponse) => emit(const UpdateFoodAttendanceSuccess()),
    );
  }
}
