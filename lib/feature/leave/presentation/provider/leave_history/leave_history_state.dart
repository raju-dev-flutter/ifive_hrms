part of 'leave_history_cubit.dart';

sealed class LeaveHistoryState extends Equatable {
  const LeaveHistoryState();

  @override
  List<Object> get props => [];
}

class LeaveHistoryInitial extends LeaveHistoryState {
  const LeaveHistoryInitial();
}

class LeaveHistoryLoading extends LeaveHistoryState {
  const LeaveHistoryLoading();
}

class LeaveHistoryLoaded extends LeaveHistoryState {
  final LeaveHistoryModel history;

  const LeaveHistoryLoaded({required this.history});

  @override
  List<Object> get props => [history];
}

class LeaveHistoryFailed extends LeaveHistoryState {
  final String message;

  const LeaveHistoryFailed({required this.message});

  @override
  List<Object> get props => [];
}
