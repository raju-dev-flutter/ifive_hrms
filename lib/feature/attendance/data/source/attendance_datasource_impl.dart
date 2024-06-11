import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../../../../core/core.dart';
import '../../attendance.dart';

class AttendanceDataSourceImpl implements AttendanceDataSource {
  const AttendanceDataSourceImpl(this._client);

  final http.Client _client;

  @override
  Future<GeoLocationResponseModel> updateWorkEndLocation(
    int battery,
    String mobileTime,
    String timestamp,
    String taskDescription,
    int type,
    double latitude,
    double longitude,
    String geoAddress,
  ) async {
    try {
      final urlParse = Uri.parse(ApiUrl.workEndLocationEndPoint);
      final token = SharedPrefs().getToken();
      final response = await _client.post(
        urlParse,
        headers: {'content-type': 'application/json', 'token': token},
        body: jsonEncode({
          'battery': battery,
          'mobile_time': mobileTime,
          'timestamp': timestamp,
          'task_desc': taskDescription,
          'geo_location': {
            'latitude': latitude,
            'longitude': longitude,
            'geo_address': geoAddress,
          }
        }),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: response.body, statusCode: response.statusCode);
      }
      final jsonResponse = jsonDecode(response.body);

      return GeoLocationResponseModel.fromMap(jsonResponse);
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<GeoLocationResponseModel> updateWorkStartLocation(DataMap body) async {
    try {
      final urlParse = Uri.parse(ApiUrl.workStartLocationEndPoint);
      final token = SharedPrefs().getToken();
      final response = await _client.post(
        urlParse,
        headers: {'content-type': 'application/json', 'token': token},
        body: jsonEncode(body),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: response.body, statusCode: response.statusCode);
      }
      final jsonResponse = jsonDecode(response.body);

      return GeoLocationResponseModel.fromMap(jsonResponse);
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<OverAllAttendanceModel> getAttendanceUserList(
      String date, String id) async {
    try {
      final urlParse = Uri.parse(ApiUrl.overallAttendanceEndPoint);
      final token = SharedPrefs().getToken();

      final response = await _client.post(urlParse,
          body: jsonEncode({"date_attendance": date}),
          headers: {'content-type': 'application/json', 'token': token});

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: response.body, statusCode: response.statusCode);
      }
      final jsonResponse = jsonDecode(response.body);

      return OverAllAttendanceModel.fromJson(jsonResponse);
    } on APIException {
      rethrow;
    } catch (e) {
      Logger().i(e.toString());
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<AttendanceReportModel> getAttendanceReportList(
      String fromDate, String toDate) async {
    try {
      final urlParse = Uri.parse(ApiUrl.attendanceReportLogEndPoint);
      final token = SharedPrefs().getToken();
      final response = await _client.post(urlParse,
          body: jsonEncode({"from_date": fromDate, "to_date": toDate}),
          headers: {'content-type': 'application/json', 'token': token});

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: response.body, statusCode: response.statusCode);
      }
      final jsonResponse = jsonDecode(response.body);
      return AttendanceReportModel.fromJson(jsonResponse);
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<GPRSResponseModel> gprsChecker() async {
    try {
      final urlParse = Uri.parse(ApiUrl.gprsCheckerEndPoint);
      final token = SharedPrefs().getToken();
      final response = await _client.post(urlParse,
          headers: {'content-type': 'application/json', 'token': token});

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: response.body, statusCode: response.statusCode);
      }
      final jsonResponse = jsonDecode(response.body);

      return GPRSResponseModel.fromJson(jsonResponse);
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }
}
