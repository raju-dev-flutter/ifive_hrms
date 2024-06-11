part of 'today_task_cubit.dart';

sealed class TodayTaskState extends Equatable {
  const TodayTaskState();

  @override
  List<Object> get props => [];
}

final class TodayTaskInitial extends TodayTaskState {}

final class TodayTaskLoading extends TodayTaskState {}

final class TodayTaskLoaded extends TodayTaskState {
  final TaskPlannerModel taskPlannerModel;

  const TodayTaskLoaded(this.taskPlannerModel);

  @override
  List<Object> get props => [taskPlannerModel];
}

final class TodayTaskFailure extends TodayTaskState {
  final String message;

  const TodayTaskFailure(this.message);

  @override
  List<Object> get props => [message];
}
