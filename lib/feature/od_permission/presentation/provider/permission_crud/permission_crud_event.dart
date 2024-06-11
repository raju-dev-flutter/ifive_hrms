part of 'permission_crud_bloc.dart';

abstract class PermissionCrudEvent extends Equatable {
  const PermissionCrudEvent();

  @override
  List<Object> get props => [];
}

class PermissionSubmitEvent extends PermissionCrudEvent {
  final DataMap body;

  const PermissionSubmitEvent({required this.body});
  @override
  List<Object> get props => [body];
}

class PermissionUpdateEvent extends PermissionCrudEvent {
  final DataMap body;

  const PermissionUpdateEvent({required this.body});
  @override
  List<Object> get props => [body];
}

class PermissionCancelEvent extends PermissionCrudEvent {
  final DataMap body;

  const PermissionCancelEvent({required this.body});
  @override
  List<Object> get props => [body];
}
