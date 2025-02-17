import 'dart:io';

import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../project_task.dart';

class TaskUpdateUseCase
    extends UseCaseWithParams<void, ProjectTaskUpdateParams> {
  const TaskUpdateUseCase(this._repository);

  final ProjectTaskRepository _repository;

  @override
  ResultVoid call(ProjectTaskUpdateParams params) async {
    return _repository.taskUpdate(params.body, params.file);
  }
}

class ProjectTaskUpdateParams extends Equatable {
  final DataMap body;
  final List<File> file;

  const ProjectTaskUpdateParams(this.body, this.file);

  @override
  List<Object> get props => [body, file];
}
