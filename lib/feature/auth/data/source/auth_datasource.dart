import '../../auth.dart';

abstract class AuthDataSource {
  Future<LoginResponseModel> login(
      String user,
      String password,
      double latitude,
      double longitude,
      String geoAddress,
      String battery,
      String imei);

  Future<void> changePassword(String password);
}
