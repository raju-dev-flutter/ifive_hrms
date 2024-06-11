import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../../../../core/core.dart';
import '../../dashboard.dart';

class DashboardDataSourceImpl implements DashboardDataSource {
  const DashboardDataSourceImpl(this._client);

  final http.Client _client;

  @override
  Future<AttendanceResponseModel> getAttendanceStatus(String token) async {
    try {
      final uriParse = Uri.parse(ApiUrl.attendanceStatus);

      final response = await _client.get(uriParse,
          headers: {'content-type': 'application/json', 'token': token});

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: response.body, statusCode: response.statusCode);
      }
      final jsonResponse = jsonDecode(response.body);

      Logger().i(jsonResponse.toString());

      if (jsonResponse["message"] == "Invalid Token") {
        throw APIException(
            message: jsonResponse["message"], statusCode: response.statusCode);
      }

      final AttendanceResponseModel attendanceResponse =
          AttendanceResponseModel.fromMap(jsonResponse);

      Logger().i(attendanceResponse.message.toString());

      return attendanceResponse;
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<AnnouncementResponseModel> appreciation() async {
    try {
      final uriParse = Uri.parse(ApiUrl.announcementEndPoints);

      final token = SharedPrefs().getToken();
      final response = await _client.post(uriParse,
          headers: {'content-type': 'application/json', 'token': token});

      final jsonResponse = jsonDecode(response.body);

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: "Network Error", statusCode: response.statusCode);
      }

      if (jsonResponse["message"] == "Invalid Token") {
        throw APIException(
            message: jsonResponse["message"], statusCode: response.statusCode);
      }

      return AnnouncementResponseModel.fromJson(jsonResponse);
    } on APIException {
      rethrow;
    } catch (e) {
      throw const APIException(message: "Network Error", statusCode: 505);
    }
  }

  @override
  Future<DashboardCountModel> dashboardCount() async {
    try {
      final uriParse = Uri.parse(ApiUrl.dashboardCountEndPoints);

      final token = SharedPrefs().getToken();
      final response = await _client.post(uriParse,
          headers: {'content-type': 'application/json', 'token': token});

      final jsonResponse = jsonDecode(response.body);

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: "Network Error", statusCode: response.statusCode);
      }

      if (jsonResponse["message"] == "Invalid Token") {
        throw APIException(
            message: jsonResponse["message"], statusCode: response.statusCode);
      }

      return DashboardCountModel.fromJson(jsonResponse);
    } on APIException {
      rethrow;
    } catch (e) {
      throw const APIException(message: "Network Error", statusCode: 505);
    }
  }

  @override
  Future<AppVersionModel> appVersion() async {
    try {
      final uriParse = Uri.parse(ApiUrl.appVersionEndPoints);

      final token = SharedPrefs().getToken();
      final response = await _client.post(uriParse,
          headers: {'content-type': 'application/json', 'token': token});

      final jsonResponse = jsonDecode(response.body);

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: "Network Error", statusCode: response.statusCode);
      }

      return AppVersionModel.fromJson(jsonResponse);
    } on APIException {
      rethrow;
    } catch (e) {
      throw const APIException(message: "Network Error", statusCode: 505);
    }
  }

  @override
  Future<ApprovalLeaveHistoryModel> approvalLeaveHistory(String date) async {
    try {
      final uriParse = Uri.parse(ApiUrl.leaveApprovedHistoryEndPoint);

      final token = SharedPrefs().getToken();
      final response = await _client.post(uriParse, headers: {
        'content-type': 'application/json',
        'token': token,
        "date": date
      });

      final jsonResponse = jsonDecode(response.body);

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: "Network Error", statusCode: response.statusCode);
      }

      return ApprovalLeaveHistoryModel.fromJson(jsonResponse);
    } on APIException {
      rethrow;
    } catch (e) {
      throw const APIException(message: "Network Error", statusCode: 505);
    }
  }

  @override
  Future<AppMenuModel> appMenu() async {
    try {
      final uriParse = Uri.parse(ApiUrl.appMenuEndPoints);

      final token = SharedPrefs().getToken();
      final response = await _client.post(uriParse,
          headers: {'content-type': 'application/json', 'token': token});

      final jsonResponse = jsonDecode(response.body);

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: "Network Error", statusCode: response.statusCode);
      }

      return AppMenuModel.fromJson(jsonResponse);
    } on APIException {
      rethrow;
    } catch (e) {
      throw const APIException(message: "Network Error", statusCode: 505);
    }
  }
}
