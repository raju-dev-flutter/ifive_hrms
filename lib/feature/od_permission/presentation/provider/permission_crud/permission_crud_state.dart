part of 'permission_crud_bloc.dart';

abstract class PermissionCrudState extends Equatable {
  const PermissionCrudState();
  @override
  List<Object> get props => [];
}

class PermissionCrudInitial extends PermissionCrudState {
  const PermissionCrudInitial();
}

class PermissionCrudLoading extends PermissionCrudState {
  const PermissionCrudLoading();
}

class PermissionCrudSuccess extends PermissionCrudState {
  const PermissionCrudSuccess();
}

class PermissionCrudFailed extends PermissionCrudState {
  final String message;

  const PermissionCrudFailed({required this.message});

  @override
  List<Object> get props => [];
}
