part of 'misspunch_crud_bloc.dart';

abstract class MisspunchCrudState extends Equatable {
  const MisspunchCrudState();

  @override
  List<Object> get props => [];
}

class MisspunchCrudInitial extends MisspunchCrudState {
  const MisspunchCrudInitial();
}

class MisspunchCrudLoading extends MisspunchCrudState {
  const MisspunchCrudLoading();
}

class MisspunchCrudSuccess extends MisspunchCrudState {
  const MisspunchCrudSuccess();

  @override
  List<Object> get props => [];
}

class MisspunchCrudFailed extends MisspunchCrudState {
  final String message;

  const MisspunchCrudFailed({required this.message});

  @override
  List<Object> get props => [];
}
