part of 'appreciation_crud_bloc.dart';

abstract class AppreciationCrudState extends Equatable {
  const AppreciationCrudState();

  @override
  List<Object> get props => [];
}

class AppreciationCrudInitial extends AppreciationCrudState {
  const AppreciationCrudInitial();
}

class AppreciationCrudLoading extends AppreciationCrudState {
  const AppreciationCrudLoading();
}

class AppreciationCrudSuccess extends AppreciationCrudState {
  const AppreciationCrudSuccess();
}

class AppreciationCrudFailed extends AppreciationCrudState {
  final String message;

  const AppreciationCrudFailed({required this.message});

  @override
  List<Object> get props => [];
}
