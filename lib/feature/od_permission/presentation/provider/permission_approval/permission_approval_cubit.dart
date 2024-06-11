import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../feature.dart';

part 'permission_approval_state.dart';

class PermissionApprovalCubit extends Cubit<PermissionApprovalState> {
  PermissionApprovalCubit({required PermissionApproval permissionApproval})
      : _permissionApproval = permissionApproval,
        super(initialState());

  final PermissionApproval _permissionApproval;

  static initialState() => const PermissionApprovalInitial();

  void getPermissionApproval() async {
    emit(const PermissionApprovalLoading());

    final response = await _permissionApproval.call();

    response.fold(
      (_) => emit(PermissionApprovalFailed(message: _.message)),
      (__) => emit(PermissionApprovalLoaded(history: __)),
    );
  }
}
