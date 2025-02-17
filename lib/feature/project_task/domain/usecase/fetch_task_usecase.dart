import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../../feature.dart';

export 'task_dept_lead_usecase.dart';

class FetchTaskUseCase
    extends UseCaseWithParams<TaskDataModel, ProjectTaskParams> {
  const FetchTaskUseCase(this._repository);

  final ProjectTaskRepository _repository;

  @override
  ResultFuture<TaskDataModel> call(ProjectTaskParams params) async {
    return _repository.fetchTask(params.header, params.page, params.perPage);
  }
}

class ProjectTaskParams extends Equatable {
  final DataMap header;
  final int page;
  final int perPage;

  const ProjectTaskParams(this.header, this.page, this.perPage);

  @override
  List<Object?> get props => [header, page, perPage];
}
