part of 'sfa_crud_bloc.dart';

sealed class SfaCrudState extends Equatable {
  const SfaCrudState();

  @override
  List<Object> get props => [];
}

class SfaCrudInitial extends SfaCrudState {
  const SfaCrudInitial();
}

class SfaCrudLoading extends SfaCrudState {
  const SfaCrudLoading();
}

class SfaCrudSuccess extends SfaCrudState {
  const SfaCrudSuccess();
}

class SfaCrudFailed extends SfaCrudState {
  final String message;

  const SfaCrudFailed({required this.message});

  @override
  List<Object> get props => [];
}
