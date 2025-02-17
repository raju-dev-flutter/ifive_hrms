import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../../feature.dart';

export 'task_dept_lead_usecase.dart';

class TaskDeptLeadUseCase
    extends UseCaseWithParams<TaskDeptBasedModel, ProjectTaskDeptLeadParams> {
  const TaskDeptLeadUseCase(this._repository);

  final ProjectTaskRepository _repository;

  @override
  ResultFuture<TaskDeptBasedModel> call(
      ProjectTaskDeptLeadParams params) async {
    return _repository.taskDeptLead(params.taskId);
  }
}

class ProjectTaskDeptLeadParams extends Equatable {
  final String taskId;

  const ProjectTaskDeptLeadParams({required this.taskId});

  @override
  List<Object> get props => [taskId];
}
