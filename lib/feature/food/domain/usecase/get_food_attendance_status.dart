import '../../../../core/core.dart';
import '../../food.dart';

class GetFoodAttendanceStatus
    extends UseCaseWithoutParams<FoodAttendanceResponse> {
  const GetFoodAttendanceStatus(this._repository);

  final FoodRepository _repository;

  @override
  ResultFuture<FoodAttendanceResponse> call() async {
    return _repository.getFoodAttendanceStatus();
  }
}
