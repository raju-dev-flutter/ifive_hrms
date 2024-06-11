import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../../../../core/core.dart';
import '../../expenses.dart';

class ExpensesDataSourceImpl implements ExpensesDataSource {
  const ExpensesDataSourceImpl(this._client);

  final http.Client _client;

  @override
  Future<void> expensesSave(DataMap body) async {
    try {
      final urlParse = Uri.parse(ApiUrl.expensesSavePoint);
      final token = SharedPrefs().getToken();
      Logger().t(body);
      final response = await _client.post(
        urlParse,
        headers: {'content-type': 'application/json', 'token': token},
        body: jsonEncode(body),
      );
      Logger().d(response.body);
      final jsonResponse = jsonDecode(response.body);
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: jsonResponse["message"], statusCode: response.statusCode);
      }
    } on APIException {
      rethrow;
    } catch (e) {
      Logger().e(e);
      throw const APIException(message: "Server Error", statusCode: 505);
    }
  }

  @override
  Future<ExpensesModel> expensesType() async {
    try {
      final urlParse = Uri.parse(ApiUrl.expensesTypeEndPoint);
      final token = SharedPrefs().getToken();
      final response = await _client.get(
        urlParse,
        headers: {'content-type': 'application/json', 'token': token},
      );
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: jsonDecode(response.body)["message"],
            statusCode: response.statusCode);
      }
      final jsonResponse = jsonDecode(response.body);
      return ExpensesModel.fromJson(jsonResponse);
    } on APIException {
      rethrow;
    } catch (e) {
      throw const APIException(message: "Network Error", statusCode: 505);
    }
  }

  @override
  Future<ExpensesDataModel> statusBasedExpensesData(DataMap header) async {
    try {
      final urlParse = Uri.parse(ApiUrl.expensesStatusBasedDataEndPoint);
      final token = SharedPrefs().getToken();

      final response = await _client.get(
        urlParse,
        headers: {
          'content-type': 'application/json',
          'token': token,
          ...header
        },
      );
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: jsonDecode(response.body)["message"],
            statusCode: response.statusCode);
      }
      final jsonResponse = jsonDecode(response.body);
      return ExpensesDataModel.fromJson(jsonResponse);
    } on APIException {
      rethrow;
    } catch (e) {
      throw const APIException(message: "Network Error", statusCode: 505);
    }
  }
}
