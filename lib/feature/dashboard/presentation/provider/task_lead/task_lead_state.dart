part of 'task_lead_cubit.dart';

sealed class TaskLeadState extends Equatable {
  const TaskLeadState();

  @override
  List<Object> get props => [];
}

class TaskLeadInitial extends TaskLeadState {
  const TaskLeadInitial();
}

class TaskLeadLoading extends TaskLeadState {
  const TaskLeadLoading();
}

class TaskLeadLoaded extends TaskLeadState {
  final List<TaskLeadData> taskLead;

  const TaskLeadLoaded({required this.taskLead});

  @override
  List<Object> get props => [taskLead];
}

class TaskLeadFailed extends TaskLeadState {
  final String message;

  const TaskLeadFailed({required this.message});

  @override
  List<Object> get props => [];
}
