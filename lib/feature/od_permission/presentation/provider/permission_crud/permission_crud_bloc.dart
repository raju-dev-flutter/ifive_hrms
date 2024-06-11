import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/core.dart';
import '../../../../feature.dart';

part 'permission_crud_event.dart';
part 'permission_crud_state.dart';

class PermissionCrudBloc
    extends Bloc<PermissionCrudEvent, PermissionCrudState> {
  PermissionCrudBloc(
      {required PermissionSubmit permissionSubmit,
      required PermissionUpdate permissionUpdate,
      required PermissionCancel permissionCancel})
      : _permissionSubmit = permissionSubmit,
        _permissionUpdate = permissionUpdate,
        _permissionCancel = permissionCancel,
        super(initialState()) {
    on<PermissionSubmitEvent>(_permissionSubmitEvent);
    on<PermissionUpdateEvent>(_permissionUpdateEvent);
    on<PermissionCancelEvent>(_permissionCancelEvent);
  }

  static initialState() => const PermissionCrudInitial();

  final PermissionSubmit _permissionSubmit;
  final PermissionUpdate _permissionUpdate;
  final PermissionCancel _permissionCancel;

  void _permissionSubmitEvent(
      PermissionSubmitEvent event, Emitter<PermissionCrudState> emit) async {
    emit(const PermissionCrudLoading());
    final response =
        await _permissionSubmit(PermissionSubmitParams(body: event.body));
    response.fold(
      (_) => emit(PermissionCrudFailed(message: _.message)),
      (__) => emit(const PermissionCrudSuccess()),
    );
  }

  void _permissionUpdateEvent(
      PermissionUpdateEvent event, Emitter<PermissionCrudState> emit) async {
    emit(const PermissionCrudLoading());
    final response =
        await _permissionUpdate(PermissionUpdateParams(body: event.body));
    response.fold(
      (_) => emit(PermissionCrudFailed(message: _.message)),
      (__) => emit(const PermissionCrudSuccess()),
    );
  }

  void _permissionCancelEvent(
      PermissionCancelEvent event, Emitter<PermissionCrudState> emit) async {
    emit(const PermissionCrudLoading());
    final response =
        await _permissionCancel(PermissionCancelParams(body: event.body));
    response.fold(
      (_) => emit(PermissionCrudFailed(message: _.message)),
      (__) => emit(const PermissionCrudSuccess()),
    );
  }
}
