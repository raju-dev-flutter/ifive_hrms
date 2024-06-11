part of 'misspunch_crud_bloc.dart';

abstract class MisspunchCrudEvent extends Equatable {
  const MisspunchCrudEvent();

  @override
  List<Object> get props => [];
}

class MisspunchRequestSaveEven extends MisspunchCrudEvent {
  final DataMap body;

  const MisspunchRequestSaveEven({required this.body});
  @override
  List<Object> get props => [body];
}

class MisspunchCancelEvent extends MisspunchCrudEvent {
  final DataMap body;

  const MisspunchCancelEvent({required this.body});
  @override
  List<Object> get props => [body];
}

class MisspunchUpdateEvent extends MisspunchCrudEvent {
  final DataMap body;

  const MisspunchUpdateEvent({required this.body});
  @override
  List<Object> get props => [body];
}
