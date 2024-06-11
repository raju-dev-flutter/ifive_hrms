import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../food.dart';

class GetFoodAttendanceUserList extends UseCaseWithParams<
    FoodAttendanceListModel, FoodReportListRequestParams> {
  const GetFoodAttendanceUserList(this._repository);

  final FoodRepository _repository;

  @override
  ResultFuture<FoodAttendanceListModel> call(
      FoodReportListRequestParams params) async {
    return _repository.getFoodAttendanceUserList(params.date);
  }
}

class FoodReportListRequestParams extends Equatable {
  final String date;

  const FoodReportListRequestParams({required this.date});

  const FoodReportListRequestParams.empty() : this(date: "_empty.date");

  @override
  List<Object?> get props => [date];
}
