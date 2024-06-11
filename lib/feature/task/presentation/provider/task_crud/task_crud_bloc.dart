import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/core.dart';
import '../../../../feature.dart';

part 'task_crud_event.dart';
part 'task_crud_state.dart';

class TaskCrudBloc extends Bloc<TaskCrudEvent, TaskCrudState> {
  final InitiatedTaskUpdateUseCase _initiatedTaskUpdateUseCase;
  final PendingTaskUpdateUseCase _pendingTaskUpdateUseCase;
  final InProgressTaskUpdateUseCase _inProgressTaskUpdateUseCase;
  final TestL1TaskTaskUpdateUseCase _testL1TaskTaskUpdateUseCase;
  final TestL2TaskTaskUpdateUseCase _testL2TaskTaskUpdateUseCase;
  final SupportTaskUseCase _supportTaskUseCase;

  TaskCrudBloc(
      {required SupportTaskUseCase supportTaskUseCase,
      required InitiatedTaskUpdateUseCase initiatedTaskUpdateUseCase,
      required PendingTaskUpdateUseCase pendingTaskUpdateUseCase,
      required InProgressTaskUpdateUseCase inProgressTaskUpdateUseCase,
      required TestL1TaskTaskUpdateUseCase testL1TaskTaskUpdateUseCase,
      required TestL2TaskTaskUpdateUseCase testL2TaskTaskUpdateUseCase})
      : _supportTaskUseCase = supportTaskUseCase,
        _initiatedTaskUpdateUseCase = initiatedTaskUpdateUseCase,
        _pendingTaskUpdateUseCase = pendingTaskUpdateUseCase,
        _inProgressTaskUpdateUseCase = inProgressTaskUpdateUseCase,
        _testL1TaskTaskUpdateUseCase = testL1TaskTaskUpdateUseCase,
        _testL2TaskTaskUpdateUseCase = testL2TaskTaskUpdateUseCase,
        super(initialState()) {
    on<CreateSupportTaskEvent>(_createSupportTaskEvent);
    on<TaskInitiatedUpdateEvent>(_taskInitiatedUpdateEvent);
    on<TaskPendingUpdateEvent>(_taskPendingUpdateEvent);
    on<TaskInProgressUpdateEvent>(_taskInProgressUpdateEvent);
    on<TaskTestL1UpdateEvent>(_taskTestL1UpdateEvent);
    on<TaskTestL2UpdateEvent>(_taskTestL2UpdateEvent);
  }

  static initialState() => TaskCrudInitial();

  void _createSupportTaskEvent(
      CreateSupportTaskEvent event, Emitter<TaskCrudState> emit) async {
    emit(TaskCrudLoading());
    final response = await _supportTaskUseCase(SupportTaskParams(event.body));
    response.fold(
      (_) => emit(TaskCrudFailure(_.message)),
      (r) => emit(TaskCrudSuccess()),
    );
  }

  void _taskInitiatedUpdateEvent(
      TaskInitiatedUpdateEvent event, Emitter<TaskCrudState> emit) async {
    emit(TaskCrudLoading());
    final response =
        await _initiatedTaskUpdateUseCase(InitiatedTaskParams(event.body));
    response.fold(
      (_) => emit(TaskCrudFailure(_.message)),
      (r) => emit(TaskCrudSuccess()),
    );
  }

  void _taskPendingUpdateEvent(
      TaskPendingUpdateEvent event, Emitter<TaskCrudState> emit) async {
    emit(TaskCrudLoading());
    final response =
        await _pendingTaskUpdateUseCase(PendingTaskParams(event.body));
    response.fold(
      (_) => emit(TaskCrudFailure(_.message)),
      (r) => emit(TaskCrudSuccess()),
    );
  }

  void _taskInProgressUpdateEvent(
      TaskInProgressUpdateEvent event, Emitter<TaskCrudState> emit) async {
    emit(TaskCrudLoading());
    final response =
        await _inProgressTaskUpdateUseCase(InProgressTaskParams(event.body));
    response.fold(
      (_) => emit(TaskCrudFailure(_.message)),
      (r) => emit(TaskCrudSuccess()),
    );
  }

  void _taskTestL1UpdateEvent(
      TaskTestL1UpdateEvent event, Emitter<TaskCrudState> emit) async {
    emit(TaskCrudLoading());
    final response =
        await _testL1TaskTaskUpdateUseCase(TestL1TaskParams(event.body));
    response.fold(
      (_) => emit(TaskCrudFailure(_.message)),
      (r) => emit(TaskCrudSuccess()),
    );
  }

  void _taskTestL2UpdateEvent(
      TaskTestL2UpdateEvent event, Emitter<TaskCrudState> emit) async {
    emit(TaskCrudLoading());
    final response =
        await _testL2TaskTaskUpdateUseCase(TestL2TaskParams(event.body));
    response.fold(
      (_) => emit(TaskCrudFailure(_.message)),
      (r) => emit(TaskCrudSuccess()),
    );
  }
}
