part of 'permission_history_cubit.dart';

abstract class PermissionHistoryState extends Equatable {
  const PermissionHistoryState();

  @override
  List<Object> get props => [];
}

class PermissionHistoryInitial extends PermissionHistoryState {
  const PermissionHistoryInitial();
}

class PermissionHistoryLoading extends PermissionHistoryState {
  const PermissionHistoryLoading();
}

class PermissionHistoryLoaded extends PermissionHistoryState {
  final PermissionResponseModel history;

  const PermissionHistoryLoaded({required this.history});

  @override
  List<Object> get props => [history];
}

class PermissionHistoryFailed extends PermissionHistoryState {
  final String message;

  const PermissionHistoryFailed({required this.message});

  @override
  List<Object> get props => [];
}
