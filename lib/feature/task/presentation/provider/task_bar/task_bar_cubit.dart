import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'task_bar_state.dart';

enum TaskItem {
  CREATED,
  INITIATED,
  PENDING,
  INPROGRESS,
  TESTINGL1,
  TESTINGL2,
  COMPLETED
}

class TaskBarCubit extends Cubit<TaskBarState> {
  TaskBarCubit() : super(initialState());

  static initialState() => const TaskBarState(TaskItem.CREATED, 0);

  void taskBarItem(TaskItem taskItem) {
    switch (taskItem) {
      case TaskItem.CREATED:
        emit(const TaskBarState(TaskItem.CREATED, 0));
        break;
      case TaskItem.INITIATED:
        emit(const TaskBarState(TaskItem.INITIATED, 1));
        break;

      case TaskItem.PENDING:
        emit(const TaskBarState(TaskItem.PENDING, 2));
        break;

      case TaskItem.INPROGRESS:
        emit(const TaskBarState(TaskItem.INPROGRESS, 3));
        break;

      case TaskItem.TESTINGL1:
        emit(const TaskBarState(TaskItem.TESTINGL1, 4));
        break;

      case TaskItem.TESTINGL2:
        emit(const TaskBarState(TaskItem.TESTINGL2, 5));
        break;

      case TaskItem.COMPLETED:
        emit(const TaskBarState(TaskItem.COMPLETED, 6));
        break;
    }
  }
}
