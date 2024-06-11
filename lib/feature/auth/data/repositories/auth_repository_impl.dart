import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../auth.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._datasource);

  final AuthDataSource _datasource;

  @override
  ResultVoid changePassword(String password) async {
    try {
      final passwordResponse = await _datasource.changePassword(password);
      return Right(passwordResponse);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<LoginResponseModel> login(
      String user,
      String password,
      double latitude,
      double longitude,
      String geoAddress,
      String battery,
      String imei) async {
    try {
      final loginResponse = await _datasource.login(
          user, password, latitude, longitude, geoAddress, battery, imei);
      return Right(loginResponse);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }
}
