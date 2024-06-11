import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../../../../core/core.dart';
import '../../other_service.dart';

class OtherServiceDataSourceImpl implements OtherServiceDataSource {
  const OtherServiceDataSourceImpl(this._client);

  final http.Client _client;

  @override
  Future<RenewalTrackerModel> renewalTracker() async {
    try {
      final urlParse = Uri.parse(ApiUrl.renewalTrackingEndPoints);
      final token = SharedPrefs().getToken();
      final response = await _client.get(urlParse,
          headers: {'content-type': 'application/json', 'token': token});
      Logger().d(response.body);
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: "Network Error", statusCode: response.statusCode);
      }
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse["message"] == "Invalid Token") {
        throw APIException(
            message: jsonResponse["message"], statusCode: response.statusCode);
      }
      return RenewalTrackerModel.fromJson(jsonResponse);
    } on APIException {
      rethrow;
    } catch (e) {
      Logger().e(e);
      throw const APIException(message: "Network Error", statusCode: 505);
    }
  }
}
