part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class LoginLoading extends AuthState {
  const LoginLoading();
}

class LoginSuccess extends AuthState {
  const LoginSuccess();
}

class LoginFailed extends AuthState {
  const LoginFailed(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}

class ChangePasswordLoading extends AuthState {
  const ChangePasswordLoading();
}

class ChangePasswordSuccess extends AuthState {
  const ChangePasswordSuccess();
}

class ChangePasswordFailed extends AuthState {
  const ChangePasswordFailed(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}
