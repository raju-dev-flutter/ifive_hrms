import '../../core/core.dart';

class AuthenticationRepository {
  Future<bool> hasPermission() async {
    final permission = SharedPrefs.instance.getBool(AppKeys.permission);
    if (permission == true && permission != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> hasToken() async {
    final token = SharedPrefs().getToken();
    if (token != '') {
      return true;
    } else {
      return false;
    }
  }

  Future<void> persistedPermission(bool permission) async {
    SharedPrefs.instance.setBool(AppKeys.permission, permission);
  }

  // Future<void> persistedToken(String token) async {}

  Future<void> deleteToken() async {
    SharedPrefs.instance.remove(AppKeys.loginToken);
  }
}
