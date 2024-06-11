import 'package:equatable/equatable.dart';
import 'package:ifive_hrms/core/core.dart';
import 'package:ifive_hrms/feature/feature.dart';

class StatusBasedTaskUseCase
    extends UseCaseWithParams<TaskPlannerModel, StatusBasedTaskParams> {
  const StatusBasedTaskUseCase(this._repository);

  final TaskRepository _repository;

  @override
  ResultFuture<TaskPlannerModel> call(StatusBasedTaskParams params) {
    return _repository.statusBasedTask(params.status, params.search);
  }
}

class StatusBasedTaskParams extends Equatable {
  final String status;
  final String search;

  const StatusBasedTaskParams(this.status, this.search);

  @override
  List<Object?> get props => [status, search];
}
