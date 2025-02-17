import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../../../../core/core.dart';
import '../../chat.dart';

class ChatDataSourceImpl implements ChatDataSource {
  const ChatDataSourceImpl(this._client);

  final http.Client _client;

  @override
  Future<ChatContactModel> fetchChatContact() async {
    try {
      final urlParse = Uri.parse(ApiUrl.chatContactEndPoint);
      final token = SharedPrefs().getToken();
      final response = await _client.get(urlParse,
          headers: {'content-type': 'application/json', 'token': token});

      final jsonResponse = jsonDecode(response.body);

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: jsonResponse["message"], statusCode: response.statusCode);
      }

      return ChatContactModel.fromJson(jsonResponse);
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<MessageContentModel> fetchMessageContent(int receiverId) async {
    try {
      final urlParse = Uri.parse(ApiUrl.messageContentEndPoint);
      final token = SharedPrefs().getToken();
      final response = await _client.get(urlParse, headers: {
        'content-type': 'application/json',
        'token': token,
        "receiverid": "$receiverId"
      });

      Logger().t(response.body);
      final jsonResponse = jsonDecode(response.body);

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: jsonResponse["message"], statusCode: response.statusCode);
      }
      return MessageContentModel.fromJson(jsonResponse);
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<void> saveMessage(DataMap body) async {
    try {
      final urlParse = Uri.parse(ApiUrl.saveMessageEndPoint);
      final token = SharedPrefs().getToken();
      final response = await _client.post(
        urlParse,
        headers: {'content-type': 'application/json', 'token': token},
        body: jsonEncode(body),
      );

      final jsonResponse = jsonDecode(response.body);

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: jsonResponse["message"], statusCode: response.statusCode);
      }
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }
}
