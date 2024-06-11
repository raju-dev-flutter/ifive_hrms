part of 'approval_leave_history_cubit.dart';

sealed class ApprovalLeaveHistoryState extends Equatable {
  const ApprovalLeaveHistoryState();

  @override
  List<Object> get props => [];
}

class ApprovalLeaveHistoryInitial extends ApprovalLeaveHistoryState {
  const ApprovalLeaveHistoryInitial();
}

class ApprovalLeaveHistoryLoading extends ApprovalLeaveHistoryState {
  const ApprovalLeaveHistoryLoading();
}

class ApprovalLeaveHistoryLoaded extends ApprovalLeaveHistoryState {
  final ApprovalLeaveHistoryModel approvalLeaveHistory;

  const ApprovalLeaveHistoryLoaded({required this.approvalLeaveHistory});

  @override
  List<Object> get props => [approvalLeaveHistory];
}

class ApprovalLeaveHistoryFailed extends ApprovalLeaveHistoryState {
  final String message;

  const ApprovalLeaveHistoryFailed({required this.message});

  @override
  List<Object> get props => [];
}
