import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../feature.dart';

part 'common_project_task_event.dart';
part 'common_project_task_state.dart';

class CommonProjectTaskBloc
    extends Bloc<CommonProjectTaskEvent, CommonProjectTaskState> {
  CommonProjectTaskBloc({required FetchTaskUseCase fetchTaskUseCase})
      : _fetchTaskUseCase = fetchTaskUseCase,
        super(initialState()) {
    on<RefreshFetchCommonProjectTask>(_refreshFetchCommonTask);
    on<FetchCommonProjectTask>(_fetchCommonTask);
  }

  final FetchTaskUseCase _fetchTaskUseCase;

  static initialState() => CommonProjectTaskInitial();

  void _refreshFetchCommonTask(RefreshFetchCommonProjectTask event,
      Emitter<CommonProjectTaskState> emit) async {
    emit(CommonProjectTaskLoading());
    final header = {
      'type': event.type,
      'search': event.search,
      'date': event.date
    };
    final response = await _fetchTaskUseCase
        .call(ProjectTaskParams(header, event.page, event.perPage));
    response.fold((_) {
      return emit(CommonProjectTaskFailed(_.message));
    }, (_) {
      final task = _.taskData ?? [];
      return emit(task.length < event.perPage
          ? CommonProjectTaskLoaded(task: task, hasReachedMax: true)
          : CommonProjectTaskLoaded(task: task, hasReachedMax: task.isEmpty));
    });
  }

  void _fetchCommonTask(FetchCommonProjectTask event,
      Emitter<CommonProjectTaskState> emit) async {
    if (state is CommonProjectTaskLoaded &&
        (state as CommonProjectTaskLoaded).hasReachedMax) {
      return;
    }

    final header = {
      'type': event.type,
      'search': event.search,
      'date': event.date
    };
    if (state is CommonProjectTaskInitial) {
      emit(CommonProjectTaskLoading());
      final response = await _fetchTaskUseCase
          .call(ProjectTaskParams(header, event.page, event.perPage));
      response.fold((_) {
        return emit(CommonProjectTaskFailed(_.message));
      }, (_) {
        final task = _.taskData ?? [];
        return emit(task.length < event.perPage
            ? CommonProjectTaskLoaded(task: task, hasReachedMax: true)
            : CommonProjectTaskLoaded(task: task, hasReachedMax: task.isEmpty));
      });
    } else if (state is CommonProjectTaskLoaded) {
      final currentState = state as CommonProjectTaskLoaded;
      final response = await _fetchTaskUseCase
          .call(ProjectTaskParams(header, event.page, event.perPage));
      response.fold((_) {
        return emit(CommonProjectTaskFailed(_.message));
      }, (_) {
        final task = _.taskData ?? [];
        return emit(task.isEmpty
            ? currentState.copyWith(hasReachedMax: true)
            : CommonProjectTaskLoaded(
                task: currentState.task + task, hasReachedMax: false));
      });
    }
  }
}
