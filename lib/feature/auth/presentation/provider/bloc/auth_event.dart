part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  final String user;
  final String password;

  final double latitude;
  final double longitude;
  final String geoAddress;
  final String battery;
  final String imei;
  const LoginEvent({
    required this.user,
    required this.password,
    required this.latitude,
    required this.longitude,
    required this.geoAddress,
    required this.battery,
    required this.imei,
  });

  @override
  List<Object> get props => [user, password];
}

class ChangePasswordEvent extends AuthEvent {
  final String password;

  const ChangePasswordEvent({required this.password});

  @override
  List<Object> get props => [password];
}
