part of 'leave_crud_bloc.dart';

sealed class LeaveCrudEvent extends Equatable {
  const LeaveCrudEvent();

  @override
  List<Object> get props => [];
}

class CreateLeaveRequestEvent extends LeaveCrudEvent {
  final DataMap body;

  const CreateLeaveRequestEvent({required this.body});
  @override
  List<Object> get props => [body];
}

class LeaveCancelEvent extends LeaveCrudEvent {
  final DataMap body;

  const LeaveCancelEvent({required this.body});
  @override
  List<Object> get props => [body];
}

class LeaveUpdateEvent extends LeaveCrudEvent {
  final DataMap body;

  const LeaveUpdateEvent({required this.body});
  @override
  List<Object> get props => [body];
}
