import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../food.dart';

part 'food_attendance_status_state.dart';

class FoodAttendanceStatusCubit extends Cubit<FoodAttendanceStatusState> {
  FoodAttendanceStatusCubit(
      {required GetFoodAttendanceStatus getFoodAttendanceStatus})
      : _getFoodAttendanceStatus = getFoodAttendanceStatus,
        super(const FoodAttendanceStatusInitial());

  final GetFoodAttendanceStatus _getFoodAttendanceStatus;

  Future<void> getFoodAttendanceStatus() async {
    emit(const FoodAttendanceStatusLoading());
    final foodAttendanceResponse = await _getFoodAttendanceStatus();

    foodAttendanceResponse.fold(
      (failure) => emit(FoodAttendanceStatusFailed(failure.message)),
      (foodResponse) => emit(
          FoodAttendanceStatusLoaded(foodAttendanceResponse: foodResponse)),
    );
  }
}
