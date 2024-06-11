import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../feature.dart';

part 'today_task_state.dart';

class TodayTaskCubit extends Cubit<TodayTaskState> {
  TodayTaskCubit({required TodayTaskUseCase todayTaskUseCase})
      : _todayTaskUseCase = todayTaskUseCase,
        super(initialState());

  final TodayTaskUseCase _todayTaskUseCase;

  static initialState() => TodayTaskInitial();

  void todayTask({required String date}) async {
    emit(TodayTaskLoading());

    final taskResponse = await _todayTaskUseCase(date);

    taskResponse.fold(
      (_) => emit(TodayTaskFailure(_.message)),
      (_) => emit(TodayTaskLoaded(_)),
    );
  }
}
