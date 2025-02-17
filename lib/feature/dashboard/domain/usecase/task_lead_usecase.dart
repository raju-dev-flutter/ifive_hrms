import '../../../../core/core.dart';
import '../../dashboard.dart';

class TaskLeadUseCase extends UseCaseWithoutParams<TaskLeadDataModel> {
  const TaskLeadUseCase(this._repository);

  final DashboardRepository _repository;

  @override
  ResultFuture<TaskLeadDataModel> call() {
    return _repository.taskLeadData();
  }
}
