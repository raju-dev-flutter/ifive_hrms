import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../../../../core/core.dart';
import '../../auth.dart';

class AuthDataSourceImpl implements AuthDataSource {
  const AuthDataSourceImpl(this._client);

  final http.Client _client;

  @override
  Future<void> changePassword(String password) async {
    try {
      final urlParse = Uri.parse(ApiUrl.changePasswordEndPoint);
      final token = SharedPrefs().getToken();
      final response = await _client.post(urlParse,
          headers: {'content-type': 'application/json', 'token': token},
          body: jsonEncode({'password': password}));

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: response.body, statusCode: response.statusCode);
      }
      final jsonResponse = jsonDecode(response.body);
      Logger().i(jsonResponse.toString());
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<LoginResponseModel> login(
      String user,
      String password,
      double latitude,
      double longitude,
      String geoAddress,
      String battery,
      String imei) async {
    try {
      final urlParse = Uri.parse(ApiUrl.loginEndPoint);
      final fcmToken = SharedPrefs.instance.getString(AppKeys.deviceToken);
      final response = await _client.post(urlParse,
          body: jsonEncode({
            'username': user,
            'password': password,
            'fcm_token': fcmToken,
            'geo_location': {
              'latitude': latitude,
              'longitude': longitude,
              'geo_address': geoAddress,
            },
            'battery': battery,
            'imei': imei,
          }),
          headers: {'content-type': 'application/json'});

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: response.body, statusCode: response.statusCode);
      }
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse["message"].toString() == "SUCCESS") {
        return LoginResponseModel.fromJson(jsonResponse);
      } else {
        throw APIException(
          message: jsonDecode(response.body)["message"].toString(),
          statusCode: response.statusCode,
        );
      }
    } on APIException {
      rethrow;
    } catch (e) {
      throw const APIException(
          message: "Server Error, try again later", statusCode: 505);
    }
  }
}
