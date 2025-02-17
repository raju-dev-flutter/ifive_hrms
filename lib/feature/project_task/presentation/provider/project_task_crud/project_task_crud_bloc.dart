import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/core.dart';
import '../../../../feature.dart';

part 'project_task_crud_event.dart';
part 'project_task_crud_state.dart';

class ProjectTaskCrudBloc
    extends Bloc<ProjectTaskCrudEvent, ProjectTaskCrudState> {
  ProjectTaskCrudBloc(
      {required TaskUpdateUseCase taskUpdateUseCase,
      required TaskSaveUseCase taskSaveUseCase})
      : _taskUpdateUseCase = taskUpdateUseCase,
        _taskSaveUseCase = taskSaveUseCase,
        super(initiateState()) {
    on<ProjectTaskApprovalEvent>(_taskApprovalEvent);
    on<ProjectTaskUpdateEvent>(_taskUpdateEvent);
    on<ProjectTaskSaveEvent>(_taskSaveEvent);
  }

  static initiateState() => const ProjectTaskCrudInitial();

  final TaskUpdateUseCase _taskUpdateUseCase;
  final TaskSaveUseCase _taskSaveUseCase;

  void _taskApprovalEvent(ProjectTaskApprovalEvent event,
      Emitter<ProjectTaskCrudState> emit) async {
    emit(const ProjectTaskCrudLoading());
    final response = await _taskUpdateUseCase
        .call(ProjectTaskUpdateParams(event.body, event.file));
    response.fold(
      (_) => emit(ProjectTaskCrudFailure(message: _.message)),
      (_) => emit(const ProjectTaskCrudSuccess()),
    );
  }

  void _taskUpdateEvent(
      ProjectTaskUpdateEvent event, Emitter<ProjectTaskCrudState> emit) async {
    emit(const ProjectTaskCrudLoading());
    final response = await _taskUpdateUseCase
        .call(ProjectTaskUpdateParams(event.body, event.file));
    response.fold(
      (_) => emit(ProjectTaskCrudFailure(message: _.message)),
      (_) => emit(const ProjectTaskCrudSuccess()),
    );
  }

  void _taskSaveEvent(
      ProjectTaskSaveEvent event, Emitter<ProjectTaskCrudState> emit) async {
    emit(const ProjectTaskCrudLoading());
    final response = await _taskSaveUseCase
        .call(ProjectTaskSaveParams(event.body, event.file));
    response.fold(
      (_) => emit(ProjectTaskCrudFailure(message: _.message)),
      (_) => emit(const ProjectTaskCrudSuccess()),
    );
  }
}
