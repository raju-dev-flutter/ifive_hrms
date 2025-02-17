import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../dashboard.dart';

part 'task_lead_state.dart';

class TaskLeadCubit extends Cubit<TaskLeadState> {
  TaskLeadCubit({required TaskLeadUseCase taskLeadUseCase})
      : _taskLeadUseCase = taskLeadUseCase,
        super(const TaskLeadInitial());

  final TaskLeadUseCase _taskLeadUseCase;

  void taskLead() async {
    emit(const TaskLeadLoading());
    final response = await _taskLeadUseCase();
    response.fold(
      (__) => emit(TaskLeadFailed(message: __.message)),
      (_) => emit(
        TaskLeadLoaded(taskLead: _.taskLeadData ?? []),
      ),
    );
  }
}
