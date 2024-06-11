import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../feature.dart';

part 'task_report_state.dart';

class TaskReportCubit extends Cubit<TaskReportState> {
  TaskReportCubit({required TaskReportUseCase taskReportUseCase})
      : _taskReportUseCase = taskReportUseCase,
        super(TaskReportInitial());

  final TaskReportUseCase _taskReportUseCase;

  static initialState() => TaskReportInitial();

  void taskReport() async {
    emit(TaskReportLoading());
    final taskResponse = await _taskReportUseCase();
    taskResponse.fold(
      (_) => emit(TaskReportFailure(_.message)),
      (_) => emit(TaskReportLoaded(_)),
    );
  }
}
