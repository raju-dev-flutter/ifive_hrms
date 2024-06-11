import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../food.dart';

part 'food_attendance_report_state.dart';

class FoodAttendanceReportCubit extends Cubit<FoodAttendanceReportState> {
  FoodAttendanceReportCubit(
      {required GetFoodAttendanceUserList getFoodAttendanceUserList})
      : _getFoodAttendanceUserList = getFoodAttendanceUserList,
        super(FoodAttendanceReportInitial());

  final GetFoodAttendanceUserList _getFoodAttendanceUserList;

  Future<void> getFoodAttendanceReportList(String date) async {
    emit(const FoodAttendanceReportLoading());
    final foodAttendanceResponse = await _getFoodAttendanceUserList(
        FoodReportListRequestParams(date: date));

    foodAttendanceResponse.fold(
      (failure) => emit(FoodAttendanceReportFailed(message: failure.message)),
      (foodResponse) =>
          emit(FoodAttendanceReportLoaded(attendanceList: foodResponse)),
    );
  }
}
