import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../../../../core/core.dart';
import '../../misspunch.dart';

class MisspunchDataSourceImpl implements MisspunchDataSource {
  const MisspunchDataSourceImpl(this._client);

  final http.Client _client;

  @override
  Future<MisspunchListModel> getMisspunchRequestList() async {
    try {
      final urlParse = Uri.parse(ApiUrl.requestEndPoint);
      final token = SharedPrefs().getToken();
      final response = await _client.post(urlParse,
          headers: {'content-type': 'application/json', 'token': token});

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: "Network Error", statusCode: response.statusCode);
      }

      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse["message"] == "Invalid Token") {
        throw APIException(
            message: jsonResponse["message"], statusCode: response.statusCode);
      }

      return MisspunchListModel.fromJson(jsonResponse);
    } on APIException {
      rethrow;
    } catch (e) {
      throw const APIException(message: "Network Error", statusCode: 505);
    }
  }

  @override
  Future<MisspunchMessageModel> misspunchRequestSave(DataMap body) async {
    try {
      final urlParse = Uri.parse(ApiUrl.misspunchRequestSubmitEndPoint);
      final token = SharedPrefs().getToken();
      final response = await _client.post(urlParse,
          body: jsonEncode(body),
          headers: {'content-type': 'application/json', 'token': token});

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: "Network Error", statusCode: response.statusCode);
      }
      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse["message"] == "Invalid Token") {
        throw APIException(
            message: jsonResponse["message"], statusCode: response.statusCode);
      }
      if (jsonResponse["message"] != "Misspunch Saved Successfully") {
        throw APIException(
            message: jsonResponse["message"], statusCode: response.statusCode);
      }

      return MisspunchMessageModel.fromJson(jsonResponse);
    } on APIException {
      rethrow;
    } catch (e) {
      throw const APIException(message: "Network Error", statusCode: 505);
    }
  }

  @override
  Future<MisspunchForwardListModel> getMisspunchForwardToList() async {
    try {
      final urlParse = Uri.parse(ApiUrl.forwardEndPoint);
      final token = SharedPrefs().getToken();
      final response = await _client.post(urlParse,
          headers: {'content-type': 'application/json', 'token': token});

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: "Network Error", statusCode: response.statusCode);
      }

      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse["message"] == "Invalid Token") {
        throw APIException(
            message: jsonResponse["message"], statusCode: response.statusCode);
      }

      return MisspunchForwardListModel.fromJson(jsonResponse);
    } on APIException {
      rethrow;
    } catch (e) {
      Logger().e(e);
      throw const APIException(message: "Network Error", statusCode: 505);
    }
  }

  @override
  Future<MisspunchHistoryModel> getMisspunchHistory(
      String fromDate, String toDate) async {
    try {
      final body = {'from_date': fromDate, 'to_date': toDate};

      final token = SharedPrefs().getToken();
      final response = await _client.post(
        Uri.parse(ApiUrl.misspunchHistoryEndPoint),
        headers: {'content-type': 'application/json', 'token': token},
        body: jsonEncode(body),
      );

      final jsonResponse = jsonDecode(response.body);
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: jsonResponse["message"], statusCode: response.statusCode);
      }
      if (jsonResponse["message"] == "Invalid Token") {
        throw APIException(
            message: jsonResponse["message"], statusCode: response.statusCode);
      }

      return MisspunchHistoryModel.fromJson(jsonResponse);
    } on APIException {
      rethrow;
    } catch (e) {
      throw const APIException(message: "Server Error", statusCode: 505);
    }
  }

  @override
  Future<void> misspunchCancel(DataMap body) async {
    try {
      final token = SharedPrefs().getToken();
      final response = await _client.post(
        Uri.parse(ApiUrl.misspunchCancelEndPoint),
        headers: {'content-type': 'application/json', 'token': token},
        body: jsonEncode(body),
      );

      final jsonResponse = jsonDecode(response.body);
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: jsonResponse["message"], statusCode: response.statusCode);
      }
      if (jsonResponse["message"] == "Invalid Token") {
        throw APIException(
            message: jsonResponse["message"], statusCode: response.statusCode);
      }
    } on APIException {
      rethrow;
    } catch (e) {
      throw const APIException(message: "Server Error", statusCode: 505);
    }
  }

  @override
  Future<MisspunchApprovedModel> misspunchApproved(
      String fromDate, String toDate) async {
    try {
      final body = {'from_date': fromDate, 'to_date': toDate};

      final token = SharedPrefs().getToken();
      final response = await _client.post(
        Uri.parse(ApiUrl.misspunchApprovedEndPoint),
        headers: {'content-type': 'application/json', 'token': token},
        body: jsonEncode(body),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: "Network Error", statusCode: response.statusCode);
      }
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse["message"] == "Invalid Token") {
        throw APIException(
            message: jsonResponse["message"], statusCode: response.statusCode);
      }
      return MisspunchApprovedModel.fromJson(jsonResponse);
    } on APIException {
      rethrow;
    } catch (e) {
      throw const APIException(message: "Server Error", statusCode: 505);
    }
  }

  @override
  Future<void> misspunchUpdate(DataMap body) async {
    try {
      final token = SharedPrefs().getToken();
      final response = await _client.post(
        Uri.parse(ApiUrl.misspunchUpdateEndPoint),
        headers: {'content-type': 'application/json', 'token': token},
        body: jsonEncode(body),
      );

      final jsonResponse = jsonDecode(response.body);
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: jsonResponse["message"], statusCode: response.statusCode);
      }
      if (jsonResponse["message"] == "Invalid Token") {
        throw APIException(
            message: jsonResponse["message"], statusCode: response.statusCode);
      }
    } on APIException {
      rethrow;
    } catch (e) {
      throw const APIException(message: "Server Error", statusCode: 505);
    }
  }
}
