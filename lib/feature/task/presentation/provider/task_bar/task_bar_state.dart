part of 'task_bar_cubit.dart';

class TaskBarState extends Equatable {
  final TaskItem taskItem;
  final int index;

  const TaskBarState(this.taskItem, this.index);

  @override
  List<Object> get props => [taskItem, index];
}
