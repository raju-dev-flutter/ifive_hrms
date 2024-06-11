part of 'task_report_cubit.dart';

sealed class TaskReportState extends Equatable {
  const TaskReportState();
  @override
  List<Object> get props => [];
}

final class TaskReportInitial extends TaskReportState {}

final class TaskReportLoading extends TaskReportState {}

final class TaskReportLoaded extends TaskReportState {
  final TaskReportModel taskReport;

  const TaskReportLoaded(this.taskReport);

  @override
  List<Object> get props => [taskReport];
}

final class TaskReportFailure extends TaskReportState {
  final String message;

  const TaskReportFailure(this.message);

  @override
  List<Object> get props => [message];
}
