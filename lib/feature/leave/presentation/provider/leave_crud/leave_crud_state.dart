part of 'leave_crud_bloc.dart';

sealed class LeaveCrudState extends Equatable {
  const LeaveCrudState();

  @override
  List<Object> get props => [];
}

class LeaveCrudInitial extends LeaveCrudState {
  const LeaveCrudInitial();
}

class LeaveCrudLoading extends LeaveCrudState {
  const LeaveCrudLoading();
}

class LeaveCrudSuccess extends LeaveCrudState {
  const LeaveCrudSuccess();
}

class LeaveCrudFailed extends LeaveCrudState {
  final String message;

  const LeaveCrudFailed({required this.message});

  @override
  List<Object> get props => [];
}
