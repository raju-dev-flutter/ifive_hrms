part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {
  const AppStarted();
  @override
  String toString() => 'AppStarted';
}

class AppPermission extends AuthenticationEvent {
  final bool permission;
  const AppPermission({required this.permission});

  @override
  List<Object> get props => [permission];

  @override
  String toString() => 'App Permission {$permission}';
}

class LoggedIn extends AuthenticationEvent {
  // final String token;
  const LoggedIn();
}

class LoggedOut extends AuthenticationEvent {
  const LoggedOut();
}
