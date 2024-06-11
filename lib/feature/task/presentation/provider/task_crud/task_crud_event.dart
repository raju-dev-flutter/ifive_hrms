part of 'task_crud_bloc.dart';

sealed class TaskCrudEvent extends Equatable {
  const TaskCrudEvent();

  @override
  List<Object> get props => [];
}

class CreateSupportTaskEvent extends TaskCrudEvent {
  final DataMap body;

  const CreateSupportTaskEvent({required this.body});

  @override
  List<Object> get props => [body];
}

class TaskInitiatedUpdateEvent extends TaskCrudEvent {
  final DataMap body;

  const TaskInitiatedUpdateEvent({required this.body});

  @override
  List<Object> get props => [body];
}

class TaskPendingUpdateEvent extends TaskCrudEvent {
  final DataMap body;

  const TaskPendingUpdateEvent({required this.body});

  @override
  List<Object> get props => [body];
}

class TaskInProgressUpdateEvent extends TaskCrudEvent {
  final DataMap body;

  const TaskInProgressUpdateEvent({required this.body});

  @override
  List<Object> get props => [body];
}

class TaskTestL1UpdateEvent extends TaskCrudEvent {
  final DataMap body;

  const TaskTestL1UpdateEvent({required this.body});

  @override
  List<Object> get props => [body];
}

class TaskTestL2UpdateEvent extends TaskCrudEvent {
  final DataMap body;

  const TaskTestL2UpdateEvent({required this.body});

  @override
  List<Object> get props => [body];
}
