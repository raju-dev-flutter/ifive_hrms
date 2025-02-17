import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../../../../core/core.dart';
import '../../project_task.dart';

class ProjectTaskDataSourceImpl implements ProjectTaskDataSource {
  const ProjectTaskDataSourceImpl(this._client);

  final http.Client _client;

  @override
  Future<TaskDataModel> fetchTask(DataMap header, int page, int parPage) async {
    try {
      final urlParse = Uri.parse(
          "${ApiUrl.fetchProjectTaskEndPoint}?page=$page&per_page=$parPage");
      final token = SharedPrefs().getToken();
      Logger().i(urlParse);
      Logger().i(token);
      final response = await _client.get(
        urlParse,
        headers: {
          'content-type': 'application/json',
          'token': token,
          ...header
        },
      );

      final jsonResponse = jsonDecode(response.body);

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: jsonResponse["message"], statusCode: response.statusCode);
      }
      return TaskDataModel.fromJson(jsonResponse);
    } on APIException {
      rethrow;
    } catch (e) {
      throw const APIException(message: "Network Error", statusCode: 505);
    }
  }

  @override
  Future<TaskDeptBasedModel> taskDeptLead(String taskId) async {
    try {
      final urlParse = Uri.parse(ApiUrl.projectTaskDeptLeadEndPoint);
      final token = SharedPrefs().getToken();
      final response = await _client.get(
        urlParse,
        headers: {
          'content-type': 'application/json',
          'token': token,
          'taskid': taskId
        },
      );

      final jsonResponse = jsonDecode(response.body);

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: jsonResponse["message"], statusCode: response.statusCode);
      }

      return TaskDeptBasedModel.fromJson(jsonResponse);
    } on APIException {
      rethrow;
    } catch (e) {
      throw const APIException(message: "Network Error", statusCode: 505);
    }
  }

  @override
  Future<void> taskUpdate(DataMap body, List<File> file) async {
    try {
      final urlParse = Uri.parse(ApiUrl.projectTaskUpdateEndPoint);
      final token = SharedPrefs().getToken();

      Logger().i(urlParse);
      Logger().i(token);
      var request = http.MultipartRequest('POST', urlParse);

      request.headers['token'] = token;
      request.fields['result'] = jsonEncode(body);

      if (file.isNotEmpty) {
        for (var file in file) {
          request.files.add(
            await http.MultipartFile.fromPath('files[]', file.path),
          );
        }
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      final jsonResponse = jsonDecode(response.body);

      if (response.statusCode != 200 && response.statusCode != 201) {
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
  Future<void> taskSave(DataMap body, List<File> file) async {
    try {
      final urlParse = Uri.parse(ApiUrl.projectTaskSaveEndPoint);
      final token = SharedPrefs().getToken();

      Logger().i(urlParse);
      Logger().i(token);
      var request = http.MultipartRequest('POST', urlParse);

      request.headers['token'] = token;
      request.fields['result'] = jsonEncode(body);

      if (file.isNotEmpty) {
        for (var file in file) {
          request.files.add(
            await http.MultipartFile.fromPath('files[]', file.path),
          );
        }
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      final jsonResponse = jsonDecode(response.body);

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: jsonResponse["message"], statusCode: response.statusCode);
      }
    } on APIException {
      rethrow;
    } catch (e) {
      throw const APIException(message: "Network Error", statusCode: 505);
    }
  }
}
