import 'package:shared_preferences/shared_preferences.dart';

import '../../feature/auth/auth.dart';
import '../core.dart';

class SharedPrefs {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static SharedPreferences get instance => _prefs;

  void setLoginResponse(LoginResponseModel loginResponse) {
    instance.setString(AppKeys.loginToken, loginResponse.mToken ?? "");
    instance.setInt(AppKeys.employeeId, loginResponse.employeeId ?? 0);
    instance.setString(
        AppKeys.employeeNumber, loginResponse.employeeNumber ?? "");
    instance.setInt(AppKeys.companyId, loginResponse.companyId ?? 0);

    instance.setString(AppKeys.latitude, loginResponse.latitude ?? '');
    instance.setString(AppKeys.longitude, loginResponse.longtitude ?? '');
    instance.setString(AppKeys.meter, (loginResponse.meter ?? 0).toString());
    instance.setString(AppKeys.enableGpsRestriction,
        (loginResponse.enableGpsRestriction ?? ''));

    instance.setString(AppKeys.userName,
        "${loginResponse.firstName ?? ""} ${loginResponse.lastName ?? ''}");
    instance.setString(AppKeys.mobileNumber, loginResponse.mobileNo ?? "");
    instance.setString(AppKeys.email, loginResponse.email ?? "");
    instance.setString(AppKeys.profile, loginResponse.avatar ?? "");
    instance.setString(AppKeys.department, loginResponse.admindeptId ?? "");
    instance.setString(AppKeys.menu, loginResponse.menuList?.menu ?? "");
  }

  void setGeoAddress(double lat, double long, String address) {
    instance.setDouble(AppKeys.currentLatitude, lat);
    instance.setDouble(AppKeys.currentLongitude, long);
    instance.setString(AppKeys.currentAddress, address);
  }

  void setMenu(String menu) => instance.setString(AppKeys.menu, menu);

  String getMenu() => instance.getString(AppKeys.menu) ?? '';

  String getToken() => instance.getString(AppKeys.loginToken) ?? '';

  int getId() => instance.getInt(AppKeys.employeeId) ?? 0;

  int companyId() => instance.getInt(AppKeys.companyId) ?? 0;
}
