part of 'common_project_task_bloc.dart';

sealed class CommonProjectTaskState extends Equatable {
  const CommonProjectTaskState();

  @override
  List<Object> get props => [];
}

final class CommonProjectTaskInitial extends CommonProjectTaskState {}

class CommonProjectTaskLoading extends CommonProjectTaskState {}

class CommonProjectTaskLoaded extends CommonProjectTaskState {
  final List<TaskData> task;
  final bool hasReachedMax;

  const CommonProjectTaskLoaded(
      {required this.task, required this.hasReachedMax});

  @override
  List<Object> get props => [task, hasReachedMax];

  CommonProjectTaskLoaded copyWith({
    List<TaskData>? task,
    bool? hasReachedMax,
  }) {
    return CommonProjectTaskLoaded(
      task: task ?? this.task,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}

class CommonProjectTaskFailed extends CommonProjectTaskState {
  final String message;

  const CommonProjectTaskFailed(this.message);

  @override
  List<Object> get props => [message];
}
