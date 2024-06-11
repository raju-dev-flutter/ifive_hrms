import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../food.dart';

class FoodRepositoryImpl implements FoodRepository {
  const FoodRepositoryImpl(this._datasource);

  final FoodDataSource _datasource;

  @override
  ResultFuture<FoodAttendanceListModel> getFoodAttendanceUserList(
      String date) async {
    try {
      final foodAttendance = await _datasource.getFoodAttendanceUserList(date);

      return Right(foodAttendance);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<FoodAttendanceResponse> getFoodAttendanceStatus() async {
    try {
      final foodAttendance = await _datasource.getFoodAttendanceStatus();

      return Right(foodAttendance);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultVoid updateFoodAttendance(String status) async {
    try {
      final foodAttendance = await _datasource.updateFoodAttendance(status);

      return Right(foodAttendance);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }
}
