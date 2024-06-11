part of 'appreciation_crud_bloc.dart';

abstract class AppreciationCrudEvent extends Equatable {
  const AppreciationCrudEvent();

  @override
  List<Object> get props => [];
}

class CreateAppreciationEvent extends AppreciationCrudEvent {
  final DataMap body;

  const CreateAppreciationEvent({required this.body});

  @override
  List<Object> get props => [body];
}
