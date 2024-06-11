part of 'task_crud_bloc.dart';

sealed class TaskCrudState extends Equatable {
  const TaskCrudState();

  @override
  List<Object> get props => [];
}

final class TaskCrudInitial extends TaskCrudState {}

final class TaskCrudLoading extends TaskCrudState {}

final class TaskCrudSuccess extends TaskCrudState {}

final class TaskCrudFailure extends TaskCrudState {
  final String message;

  const TaskCrudFailure(this.message);

  @override
  List<Object> get props => [message];
}
