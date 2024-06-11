import '../../../../core/core.dart';
import '../../auth.dart';

abstract class AuthRepository {
  ResultFuture<LoginResponseModel> login(
      String user,
      String password,
      double latitude,
      double longitude,
      String geoAddress,
      String battery,
      String imei);

  ResultVoid changePassword(String password);
}
