import '../../../../core/core.dart';
import '../../../feature.dart';

class TaskReportUseCase extends UseCaseWithoutParams<TaskReportModel> {
  const TaskReportUseCase(this._repository);

  final TaskRepository _repository;

  @override
  ResultFuture<TaskReportModel> call() async {
    return _repository.taskReport();
  }
}
