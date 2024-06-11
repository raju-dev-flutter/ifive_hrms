import '../../../../core/core.dart';
import '../../food.dart';

abstract class FoodRepository {
  ResultFuture<FoodAttendanceListModel> getFoodAttendanceUserList(String date);

  ResultVoid updateFoodAttendance(String status);

  ResultFuture<FoodAttendanceResponse> getFoodAttendanceStatus();
}
