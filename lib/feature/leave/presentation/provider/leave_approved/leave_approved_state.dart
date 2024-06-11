part of 'leave_approved_cubit.dart';

abstract class LeaveApprovedState extends Equatable {
  const LeaveApprovedState();

  @override
  List<Object> get props => [];
}

class LeaveApprovedInitial extends LeaveApprovedState {
  const LeaveApprovedInitial();
}

class LeaveApprovedLoading extends LeaveApprovedState {
  const LeaveApprovedLoading();
}

class LeaveApprovedLoaded extends LeaveApprovedState {
  final LeaveApprovedModel approved;

  const LeaveApprovedLoaded({required this.approved});

  @override
  List<Object> get props => [approved];
}

class LeaveApprovedFailed extends LeaveApprovedState {
  final String message;

  const LeaveApprovedFailed({required this.message});

  @override
  List<Object> get props => [];
}
