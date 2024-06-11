part of 'status_based_task_cubit.dart';

sealed class StatusBasedTaskState extends Equatable {
  const StatusBasedTaskState();

  @override
  List<Object> get props => [];
}

final class StatusBasedTaskInitial extends StatusBasedTaskState {}

final class StatusBasedTaskLoading extends StatusBasedTaskState {}

final class StatusBasedTaskLoaded extends StatusBasedTaskState {
  final TaskPlannerModel taskPlannerModel;

  const StatusBasedTaskLoaded(this.taskPlannerModel);

  @override
  List<Object> get props => [taskPlannerModel];
}

final class StatusBasedTaskFailure extends StatusBasedTaskState {
  final String message;

  const StatusBasedTaskFailure(this.message);

  @override
  List<Object> get props => [message];
}
