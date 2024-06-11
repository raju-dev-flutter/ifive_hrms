import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../../../../core/core.dart';
import '../../leave.dart';

class LeaveDataSourceImpl implements LeaveDataSource {
  const LeaveDataSourceImpl(this._client);

  final http.Client _client;

  @override
  Future<LeaveForwardModel> leaveForward(type, noOfDay) async {
    try {
      final urlParse = Uri.parse(
          "${ApiUrl.leaveForwardEndPoint}?leave_type=$type&nodays=$noOfDay");
      final token = SharedPrefs().getToken();
      final response = await _client.get(
        urlParse,
        headers: {'content-type': 'application/json', 'token': token},
      );
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: "Network Error", statusCode: response.statusCode);
      }
      final jsonResponse = jsonDecode(response.body);

      final LeaveForwardModel leaveForward =
          LeaveForwardModel.fromJson(jsonResponse);

      return leaveForward;
    } on APIException {
      rethrow;
    } catch (e) {
      throw const APIException(message: "Network Error", statusCode: 505);
    }
  }

  @override
  Future<LeaveModeModel> leaveMode(int type) async {
    try {
      final urlParse = Uri.parse(ApiUrl.leaveModeEndPoint);
      final token = SharedPrefs().getToken();
      final response = await _client.post(
        urlParse,
        headers: {'content-type': 'application/json', 'token': token},
        body: jsonEncode({'type_id': type}),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: "Network Error", statusCode: response.statusCode);
      }
      final jsonResponse = jsonDecode(response.body);

      final LeaveModeModel leaveMode = LeaveModeModel.fromJson(jsonResponse);

      return leaveMode;
    } on APIException {
      rethrow;
    } catch (e) {
      throw const APIException(message: "Network Error", statusCode: 505);
    }
  }

  @override
  Future<RemainingLeaveModel> leaveRemaining(int type) async {
    try {
      final urlParse = Uri.parse(ApiUrl.leaveBalanceEndPoint);
      final token = SharedPrefs().getToken();
      final response = await _client.post(
        urlParse,
        headers: {'content-type': 'application/json', 'token': token},
        body: jsonEncode({'type': type}),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: "Network Error", statusCode: response.statusCode);
      }
      final jsonResponse = jsonDecode(response.body);

      final RemainingLeaveModel remainingLeave =
          RemainingLeaveModel.fromJson(jsonResponse);

      return remainingLeave;
    } on APIException {
      rethrow;
    } catch (e) {
      throw const APIException(message: "Network Error", statusCode: 505);
    }
  }

  @override
  Future<void> leaveRequest(DataMap body) async {
    try {
      final urlParse = Uri.parse(ApiUrl.leaveRequestEndPoint);
      final token = SharedPrefs().getToken();
      final response = await _client.post(urlParse,
          headers: {'content-type': 'application/json', 'token': token},
          body: jsonEncode(body));

      final jsonResponse = jsonDecode(response.body);

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: "Network Error", statusCode: response.statusCode);
      }
      if (jsonResponse["message"] == "Invalid Token") {
        throw APIException(
            message: jsonResponse["message"], statusCode: response.statusCode);
      }
      if (jsonResponse["message"] != "Leave send Successfully" &&
          jsonResponse["message"] != "Leave send Successfully2") {
        throw APIException(
          message: jsonDecode(response.body)["message"].toString(),
          statusCode: response.statusCode,
        );
      }
    } on APIException {
      rethrow;
    } catch (e) {
      Logger().e(e.toString());
      throw const APIException(message: "Network Error", statusCode: 505);
    }
  }

  @override
  Future<LeaveTypeModel> leaveType() async {
    try {
      final urlParse = Uri.parse(ApiUrl.leaveTypeEndPoint);
      final token = SharedPrefs().getToken();
      final response = await _client.post(urlParse,
          headers: {'content-type': 'application/json', 'token': token});

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: "Network Error", statusCode: response.statusCode);
      }
      final jsonResponse = jsonDecode(response.body);

      final LeaveTypeModel leaveType = LeaveTypeModel.fromJson(jsonResponse);

      return leaveType;
    } on APIException {
      rethrow;
    } catch (e) {
      throw const APIException(message: "Network Error", statusCode: 505);
    }
  }

  @override
  Future<LeaveHistoryModel> leaveHistory() async {
    try {
      final urlParse = Uri.parse(ApiUrl.leaveUserHistoryEndPoint);
      final token = SharedPrefs().getToken();
      final response = await _client.post(urlParse,
          headers: {'content-type': 'application/json', 'token': token});

      Logger().t(response.body.toString());
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: "Network Error", statusCode: response.statusCode);
      }

      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse["message"] == "Invalid Token") {
        throw APIException(
            message: jsonResponse["message"], statusCode: response.statusCode);
      }
      final LeaveHistoryModel leaveHistory =
          LeaveHistoryModel.fromJson(jsonResponse);

      return leaveHistory;
    } on APIException {
      rethrow;
    } catch (e) {
      Logger().e(e.toString());
      throw const APIException(message: "Network Error", statusCode: 505);
    }
  }

  @override
  Future<LeaveApprovedModel> leaveApproved(
      String fromDate, String toDate) async {
    try {
      final urlParse = Uri.parse(ApiUrl.leaveApprovedEndPoint);
      final token = SharedPrefs().getToken();
      final response = await _client.post(
        urlParse,
        headers: {'content-type': 'application/json', 'token': token},
        body: jsonEncode({"from_date": fromDate, "to_date": toDate}),
      );
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: "Network Error", statusCode: response.statusCode);
      }
      Logger().i(response.body);
      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse["message"] == "Invalid Token") {
        throw APIException(
            message: jsonResponse["message"], statusCode: response.statusCode);
      }
      final LeaveApprovedModel leaveResponse =
          LeaveApprovedModel.fromJson(jsonResponse);

      return leaveResponse;
    } on APIException {
      rethrow;
    } catch (e) {
      throw const APIException(message: "Network Error", statusCode: 505);
    }
  }

  @override
  Future<void> leaveCancel(DataMap body) async {
    try {
      final urlParse = Uri.parse(ApiUrl.leaveCancelEndPoint);
      final token = SharedPrefs().getToken();
      final response = await _client.post(urlParse,
          headers: {'content-type': 'application/json', 'token': token},
          body: jsonEncode(body));

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: "Network Error", statusCode: response.statusCode);
      }
      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse["message"] == "Invalid Token") {
        throw APIException(
            message: jsonResponse["message"], statusCode: response.statusCode);
      }
    } on APIException {
      rethrow;
    } catch (e) {
      throw const APIException(message: "Network Error", statusCode: 505);
    }
  }

  @override
  Future<void> leaveUpdate(DataMap body) async {
    try {
      final urlParse = Uri.parse(ApiUrl.leaveUpdateEndPoint);
      final token = SharedPrefs().getToken();
      final response = await _client.post(urlParse,
          headers: {'content-type': 'application/json', 'token': token},
          body: jsonEncode(body));
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: "Network Error", statusCode: response.statusCode);
      }
      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse["message"] == "Invalid Token") {
        throw APIException(
            message: jsonResponse["message"], statusCode: response.statusCode);
      }
    } on APIException {
      rethrow;
    } catch (e) {
      throw const APIException(message: "Network Error", statusCode: 505);
    }
  }

  @override
  Future<LeaveBalanceModel> leaveBalanceCalculate(DataMap body) async {
    try {
      final urlParse = Uri.parse(ApiUrl.leaveBalanceCalculateEndPoint);
      final token = SharedPrefs().getToken();
      final response = await _client.post(urlParse,
          headers: {'content-type': 'application/json', 'token': token},
          body: jsonEncode(body));
      final jsonResponse = jsonDecode(response.body);
      Logger().i(response.body);
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: "Network Error", statusCode: response.statusCode);
      }
      if (jsonResponse["message"] == "Invalid Token") {
        throw APIException(
            message: jsonResponse["message"], statusCode: response.statusCode);
      }
      return LeaveBalanceModel.fromJson(jsonResponse);
    } on APIException {
      rethrow;
    } catch (e) {
      throw const APIException(message: "Network Error", statusCode: 505);
    }
  }
}
