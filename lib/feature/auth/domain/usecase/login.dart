import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../auth.dart';

class Login extends UseCaseWithParams<LoginResponseModel, LoginParams> {
  const Login(this._repository);

  final AuthRepository _repository;

  @override
  ResultFuture<LoginResponseModel> call(LoginParams params) async {
    return _repository.login(params.user, params.password, params.latitude,
        params.longitude, params.geoAddress, params.battery, params.imei);
  }
}

class LoginParams extends Equatable {
  final String user;
  final String password;

  final double latitude;
  final double longitude;
  final String geoAddress;
  final String battery;
  final String imei;

  const LoginParams({
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
