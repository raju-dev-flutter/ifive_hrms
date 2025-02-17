part of 'project_task_crud_bloc.dart';

sealed class ProjectTaskCrudState extends Equatable {
  const ProjectTaskCrudState();

  @override
  List<Object> get props => [];
}

final class ProjectTaskCrudInitial extends ProjectTaskCrudState {
  const ProjectTaskCrudInitial();
}

final class ProjectTaskCrudLoading extends ProjectTaskCrudState {
  const ProjectTaskCrudLoading();
}

final class ProjectTaskCrudSuccess extends ProjectTaskCrudState {
  const ProjectTaskCrudSuccess();
}

final class ProjectTaskCrudFailure extends ProjectTaskCrudState {
  final String message;

  const ProjectTaskCrudFailure({required this.message});

  @override
  List<Object> get props => [message];
}
