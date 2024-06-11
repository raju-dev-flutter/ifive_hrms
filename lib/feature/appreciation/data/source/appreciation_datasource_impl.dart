import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/core.dart';
import '../../appreciation.dart';

class AppreciationDataSourceImpl implements AppreciationDataSource {
  const AppreciationDataSourceImpl(this._client);

  final http.Client _client;

  @override
  Future<void> appreciationRequest(DataMap body) async {
    try {
      final urlParse = Uri.parse(ApiUrl.createAppreciationEndPoints);
      final token = SharedPrefs().getToken();
      final response = await _client.post(
        urlParse,
        headers: {'content-type': 'application/json', 'token': token},
        body: jsonEncode(body),
      );

      final jsonResponse = jsonDecode(response.body);

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: response.body, statusCode: response.statusCode);
      }
      if (jsonResponse == null) {
        throw APIException(
            message: "Network Error", statusCode: response.statusCode);
      }
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<EmployeeUserModel> employeeUserList() async {
    try {
      final urlParse = Uri.parse(ApiUrl.employeeListEndPoint);
      final token = SharedPrefs().getToken();
      final response = await _client.get(
        urlParse,
        headers: {'content-type': 'application/json', 'token': token},
      );

      final jsonResponse = jsonDecode(response.body);

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: response.body, statusCode: response.statusCode);
      }
      if (jsonResponse == null) {
        throw APIException(
            message: "Network Error", statusCode: response.statusCode);
      }
      return EmployeeUserModel.fromJson(jsonResponse);
    } on APIException {
      rethrow;
    } catch (e) {
      throw const APIException(message: "Network Error", statusCode: 505);
    }
  }
}
