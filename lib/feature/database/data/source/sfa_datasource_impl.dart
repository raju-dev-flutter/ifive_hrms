import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../../../../core/core.dart';
import '../../database.dart';

class SfaDataSourceImpl implements SfaDataSource {
  const SfaDataSourceImpl(this._client);

  final http.Client _client;

  @override
  Future<TicketDropdownModel> getTicketDropdown() async {
    try {
      final uriParse = Uri.parse(ApiUrl.ticketDropdownListEndPoint);

      final token = SharedPrefs().getToken();
      final response = await _client.get(
        uriParse,
        headers: {'content-type': 'application/json', 'token': token},
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

      return TicketDropdownModel.fromJson(jsonResponse);
    } on APIException {
      rethrow;
    } catch (e) {
      throw const APIException(message: "Network Error", statusCode: 505);
    }
  }

  @override
  Future<TicketDropdownModel> industryBasedVerticalDropdown(int id) async {
    try {
      final uriParse = Uri.parse(ApiUrl.industryBasedVerticalDropdownEndPoint);

      final token = SharedPrefs().getToken();
      final response = await _client.get(
        uriParse,
        headers: {
          'content-type': 'application/json',
          'token': token,
          'id': '$id'
        },
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

      return TicketDropdownModel.fromJson(jsonResponse);
    } on APIException {
      rethrow;
    } catch (e) {
      throw const APIException(message: "Network Error", statusCode: 505);
    }
  }

  @override
  Future<TicketDropdownModel> verticalBasedSubVerticalDropdown(int id) async {
    try {
      final uriParse =
          Uri.parse(ApiUrl.verticalBasedSubVerticalDropdownEndPoint);

      final token = SharedPrefs().getToken();
      final response = await _client.get(
        uriParse,
        headers: {
          'content-type': 'application/json',
          'token': token,
          'id': '$id'
        },
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

      return TicketDropdownModel.fromJson(jsonResponse);
    } on APIException {
      rethrow;
    } catch (e) {
      throw const APIException(message: "Network Error", statusCode: 505);
    }
  }

  @override
  Future<void> uploadGenerateTicket(DataMap body, String type) async {
    try {
      final uriParse = Uri.parse(ApiUrl.generateTicketEndPoint);

      final token = SharedPrefs().getToken();
      final response = await _client.post(
        uriParse,
        headers: {
          'content-type': 'application/json',
          'token': token,
          'type': type
        },
        body: jsonEncode(body),
      );

      Logger().t(response.body);
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
      Logger().e(e);
      throw const APIException(message: "Network Error", statusCode: 505);
    }
  }

  @override
  Future<DatabaseDataModel> getTicket(
      DataMapString header, int page, int parPage) async {
    try {
      final uriParse = Uri.parse(
          "${ApiUrl.databaseDataEndPoint}?page=$page&per_page=$parPage");

      final token = SharedPrefs().getToken();
      final response = await _client.get(
        uriParse,
        headers: {
          'content-type': 'application/json',
          'token': token,
          ...header
        },
      );

      final jsonResponse = jsonDecode(response.body);
      // Logger().t(jsonResponse);
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: jsonResponse["message"], statusCode: response.statusCode);
      }

      if (jsonResponse["message"] == "Invalid Token") {
        throw APIException(
            message: jsonResponse["message"], statusCode: response.statusCode);
      }

      return DatabaseDataModel.fromJson(jsonResponse);
    } on APIException {
      rethrow;
    } catch (e) {
      throw const APIException(message: "Network Error", statusCode: 505);
    }
  }
}
