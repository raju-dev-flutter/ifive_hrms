import '../../food.dart';

abstract class FoodDataSource {
  Future<FoodAttendanceListModel> getFoodAttendanceUserList(String date);

  Future<void> updateFoodAttendance(String status);

  Future<FoodAttendanceResponseModel> getFoodAttendanceStatus();
}
