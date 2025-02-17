import 'dart:io';

import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../project_task.dart';

class TaskSaveUseCase extends UseCaseWithParams<void, ProjectTaskSaveParams> {
  const TaskSaveUseCase(this._repository);

  final ProjectTaskRepository _repository;

  @override
  ResultVoid call(ProjectTaskSaveParams params) async {
    return _repository.taskSave(params.body, params.file);
  }
}

class ProjectTaskSaveParams extends Equatable {
  final DataMap body;
  final List<File> file;

  const ProjectTaskSaveParams(this.body, this.file);

  @override
  List<Object> get props => [body, file];
}
