import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../../../../core/core.dart';
import '../../calendar.dart';

class CalendarDataSourceImpl implements CalendarDataSource {
  const CalendarDataSourceImpl(this._client);

  final http.Client _client;

  @override
  Future<HolidayHistoryModel> holidayHistory() async {
    try {
      final urlParse = Uri.parse(ApiUrl.holidayHistoryEndPoint);
      final token = SharedPrefs().getToken();
      final response = await _client.post(urlParse,
          headers: {'content-type': 'application/json', 'token': token});

      if (response.statusCode != 200 && response.statusCode != 201) {
        Logger().t(response.body.toString());
        throw APIException(
            message: response.body, statusCode: response.statusCode);
      }
      final jsonResponse = jsonDecode(response.body);
      Logger().i(jsonResponse.toString());
      if (jsonResponse == null) {
        throw APIException(
          message: jsonDecode(response.body)["message"].toString(),
          statusCode: response.statusCode,
        );
      }
      final HolidayHistoryModel holidayHistory =
          HolidayHistoryModel.fromJson(jsonResponse);

      return holidayHistory;
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<LeavesHistoryModel> leavesHistory() async {
    try {
      final urlParse = Uri.parse(ApiUrl.leavesHistoryEndPoint);
      final token = SharedPrefs().getToken();
      final response = await _client.post(urlParse,
          headers: {'content-type': 'application/json', 'token': token});

      if (response.statusCode != 200 && response.statusCode != 201) {
        Logger().t(response.body.toString());
        throw APIException(
            message: response.body, statusCode: response.statusCode);
      }
      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse == null) {
        throw APIException(
          message: jsonDecode(response.body)["message"].toString(),
          statusCode: response.statusCode,
        );
      }
      final LeavesHistoryModel leavesHistory =
          LeavesHistoryModel.fromJson(jsonResponse);

      return leavesHistory;
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<PresentHistoryModel> presentHistory(
      String fromDate, String toDate) async {
    try {
      final urlParse = Uri.parse(ApiUrl.presentHistoryEndPoint);
      final token = SharedPrefs().getToken();
      final response = await _client.post(urlParse,
          headers: {'content-type': 'application/json', 'token': token},
          body: jsonEncode({"from_date": fromDate, "to_date": toDate}));

      if (response.statusCode != 200 && response.statusCode != 201) {
        Logger().t(response.body.toString());
        throw APIException(
            message: response.body, statusCode: response.statusCode);
      }
      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse == null) {
        throw APIException(
          message: jsonDecode(response.body)["message"].toString(),
          statusCode: response.statusCode,
        );
      }
      final PresentHistoryModel presentHistory =
          PresentHistoryModel.fromJson(jsonResponse);

      return presentHistory;
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<AbsentHistoryModel> absentHistory(
      String fromDate, String toDate) async {
    try {
      final urlParse = Uri.parse(ApiUrl.absentHistoryEndPoint);
      final token = SharedPrefs().getToken();
      final response = await _client.post(urlParse,
          headers: {'content-type': 'application/json', 'token': token},
          body: jsonEncode({"from_date": fromDate, "to_date": toDate}));

      if (response.statusCode != 200 && response.statusCode != 201) {
        Logger().t(response.body.toString());
        throw APIException(
            message: response.body, statusCode: response.statusCode);
      }
      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse == null) {
        throw APIException(
          message: jsonDecode(response.body)["message"].toString(),
          statusCode: response.statusCode,
        );
      }

      return AbsentHistoryModel.fromJson(jsonResponse);
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }
}
