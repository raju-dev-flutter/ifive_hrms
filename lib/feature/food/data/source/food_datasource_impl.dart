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
      final response = await _client.post(urlParse,
          // body: jsonEncode({"checkdate": date}),
          headers: {
            'content-type': 'application/json',
            'token': token,
            "checkdate": date
          });

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: response.body, statusCode: response.statusCode);
      }
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse["message"] == "Please End Attendance") {
        throw APIException(
          message: jsonDecode(response.body)["message"].toString(),
          statusCode: response.statusCode,
        );
      } else {
        Logger().i(jsonResponse.toString());
        final FoodAttendanceListModel foodAttendanceList =
            FoodAttendanceListModel.fromJson(jsonResponse);

        return foodAttendanceList;
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
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: response.body, statusCode: response.statusCode);
      }
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse == null) {
        throw APIException(
          message: jsonDecode(response.body)["message"].toString(),
          statusCode: response.statusCode,
        );
      } else {
        Logger().e(jsonResponse.toString());
        final FoodAttendanceResponseModel foodAttendanceResponse =
            FoodAttendanceResponseModel.fromMap(jsonResponse);

        return foodAttendanceResponse;
      }
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

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: response.body, statusCode: response.statusCode);
      }
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse["message"] == "Please End Attendance") {
        throw APIException(
          message: jsonDecode(response.body)["message"].toString(),
          statusCode: response.statusCode,
        );
      }
      // else {
      //   Logger().i(jsonResponse.toString());
      //   final FoodAttendanceResponseModel foodAttendanceResponse =
      //       FoodAttendanceResponseModel.fromJson(jsonResponse);
      //
      //   return foodAttendanceResponse;
      // }
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }
}
