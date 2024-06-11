import '../../../../core/core.dart';
import '../../../feature.dart';

class TodayTaskUseCase extends UseCaseWithParams<TaskPlannerModel, String> {
  const TodayTaskUseCase(this._repository);

  final TaskRepository _repository;

  @override
  ResultFuture<TaskPlannerModel> call(String params) async {
    return await _repository.todayTask(params);
  }
}
