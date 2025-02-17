part of 'project_task_crud_bloc.dart';

sealed class ProjectTaskCrudEvent extends Equatable {
  const ProjectTaskCrudEvent();

  @override
  List<Object> get props => [];
}

final class ProjectTaskApprovalEvent extends ProjectTaskCrudEvent {
  final DataMap body;
  final List<File> file;

  const ProjectTaskApprovalEvent({required this.body, required this.file});

  @override
  List<Object> get props => [body, file];
}

final class ProjectTaskUpdateEvent extends ProjectTaskCrudEvent {
  final DataMap body;
  final List<File> file;

  const ProjectTaskUpdateEvent({required this.body, required this.file});

  @override
  List<Object> get props => [body, file];
}

final class ProjectTaskSaveEvent extends ProjectTaskCrudEvent {
  final DataMap body;
  final List<File> file;

  const ProjectTaskSaveEvent({required this.body, required this.file});

  @override
  List<Object> get props => [body, file];
}
