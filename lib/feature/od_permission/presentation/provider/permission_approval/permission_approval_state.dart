part of 'permission_approval_cubit.dart';

abstract class PermissionApprovalState extends Equatable {
  const PermissionApprovalState();

  @override
  List<Object> get props => [];
}

class PermissionApprovalInitial extends PermissionApprovalState {
  const PermissionApprovalInitial();
}

class PermissionApprovalLoading extends PermissionApprovalState {
  const PermissionApprovalLoading();
}

class PermissionApprovalLoaded extends PermissionApprovalState {
  final PermissionHistoryModel history;

  const PermissionApprovalLoaded({required this.history});

  @override
  List<Object> get props => [history];
}

class PermissionApprovalFailed extends PermissionApprovalState {
  final String message;

  const PermissionApprovalFailed({required this.message});

  @override
  List<Object> get props => [];
}
