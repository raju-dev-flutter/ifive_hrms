import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../../../../core/core.dart';
import '../../food.dart';

class FoodDataSourceImpl implements FoodDataSource {
  const FoodDataSourceImpl(this._client);

  final http.Client _client;

  @override
  Future<FoodAttendanceListModel> getFoodAttendanceUserList(String date) async {
    try {
      final urlParse = Uri.parse(ApiUrl.foodAttendanceReportEndPoint);
      final token = SharedPrefs().getToken();
      final response = await _client.post(urlParse, headers: {
        'content-type': 'application/json',
        'token': token,
        "checkdate": date
      });

      final jsonResponse = jsonDecode(response.body);
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: jsonResponse["message"], statusCode: response.statusCode);
      }
      if (jsonResponse["message"] == "Please End Attendance") {
        throw APIException(
            message: jsonResponse["message"], statusCode: response.statusCode);
      } else {
        return FoodAttendanceListModel.fromJson(jsonResponse);
      }
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<FoodAttendanceResponseModel> getFoodAttendanceStatus() async {
    try {
      final urlParse = Uri.parse(ApiUrl.foodAttendanceStatusEndPoint);
      final token = SharedPrefs().getToken();
      final response = await _client.post(urlParse,
          headers: {'content-type': 'application/json', 'token': token});

      Logger().e(response.body.toString());

      final jsonResponse = jsonDecode(response.body);
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: jsonResponse["message"], statusCode: response.statusCode);
      }

      return FoodAttendanceResponseModel.fromMap(jsonResponse);
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<void> updateFoodAttendance(String status) async {
    try {
      final urlParse = Uri.parse(ApiUrl.updateFoodAttendanceEndPoint);
      final token = SharedPrefs().getToken();
      final response = await _client.post(urlParse, headers: {
        'content-type': 'application/json',
        'token': token,
        "status": status
      });

      final jsonResponse = jsonDecode(response.body);
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: jsonResponse["message"], statusCode: response.statusCode);
      }
      if (jsonResponse["message"] == "Please End Attendance") {
        throw APIException(
            message: jsonResponse["message"], statusCode: response.statusCode);
      }
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }
}
