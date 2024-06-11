import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/core.dart';
import '../../payroll.dart';

class PayrollDataSourceImpl implements PayrollDataSource {
  const PayrollDataSourceImpl(this._client);

  final http.Client _client;

  @override
  Future<PaySlipResponseModel> payslip(String fromDate, String toDate) async {
    try {
      final uriParse = Uri.parse(ApiUrl.payrollListEndPoints);

      final token = SharedPrefs().getToken();
      final response = await _client.post(
        uriParse,
        headers: {'content-type': 'application/json', 'token': token},
        body: jsonEncode({'from_date': fromDate, 'to_date': toDate}),
      );

      final jsonResponse = jsonDecode(response.body);

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: "Network Error", statusCode: response.statusCode);
      }

      if (jsonResponse["message"] == "Invalid Token") {
        throw APIException(
            message: jsonResponse["message"], statusCode: response.statusCode);
      }

      return PaySlipResponseModel.fromJson(jsonResponse);
    } on APIException {
      rethrow;
    } catch (e) {
      throw const APIException(message: "Network Error", statusCode: 505);
    }
  }

  @override
  Future<PaySlipModel> payslipDocument(String id) async {
    try {
      final uriParse = Uri.parse(ApiUrl.payrollDocumentEndPoints);

      final token = SharedPrefs().getToken();
      final response = await _client.post(uriParse, headers: {
        'content-type': 'application/json',
        'token': token,
        'id': id
      });

      final jsonResponse = jsonDecode(response.body);

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: "Network Error", statusCode: response.statusCode);
      }

      if (jsonResponse["message"] == "Invalid Token") {
        throw APIException(
            message: jsonResponse["message"], statusCode: response.statusCode);
      }

      return PaySlipModel.fromJson(jsonResponse);
    } on APIException {
      rethrow;
    } catch (e) {
      throw const APIException(message: "Network Error", statusCode: 505);
    }
  }
}
