part of 'account_crud_bloc.dart';

abstract class AccountCrudState extends Equatable {
  const AccountCrudState();

  @override
  List<Object> get props => [];
}

class AccountCrudInitial extends AccountCrudState {
  const AccountCrudInitial();
}

class AccountCrudLoading extends AccountCrudState {
  const AccountCrudLoading();
}

class AccountCrudSuccess extends AccountCrudState {
  const AccountCrudSuccess();
}

class AccountCrudFailed extends AccountCrudState {
  final String message;

  const AccountCrudFailed({required this.message});

  @override
  List<Object> get props => [];
}
