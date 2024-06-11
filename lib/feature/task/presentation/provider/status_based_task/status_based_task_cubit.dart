import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../feature.dart';

part 'status_based_task_state.dart';

class StatusBasedTaskCubit extends Cubit<StatusBasedTaskState> {
  StatusBasedTaskCubit({required StatusBasedTaskUseCase statusBasedTaskUseCase})
      : _statusBasedTaskUseCase = statusBasedTaskUseCase,
        super(initialState());

  final StatusBasedTaskUseCase _statusBasedTaskUseCase;

  static initialState() => StatusBasedTaskInitial();

  void statusBasedTask({required String status, required String search}) async {
    emit(StatusBasedTaskLoading());

    final taskResponse =
        await _statusBasedTaskUseCase(StatusBasedTaskParams(status, search));

    taskResponse.fold(
      (_) => emit(StatusBasedTaskFailure(_.message)),
      (_) => emit(StatusBasedTaskLoaded(_)),
    );
  }
}
