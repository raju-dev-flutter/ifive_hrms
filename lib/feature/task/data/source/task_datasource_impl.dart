import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../../../../core/core.dart';
import '../../task.dart';

class TaskDataSourceImpl implements TaskDataSource {
  const TaskDataSourceImpl(this._client);

  final http.Client _client;

  @override
  Future<EmployeeModel> employeeList() async {
    try {
      final urlParse = Uri.parse(ApiUrl.employeeListEndPoint);
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
      return EmployeeModel.fromJson(jsonResponse);
    } on APIException {
      rethrow;
    } catch (e) {
      throw const APIException(message: "Network Error", statusCode: 505);
    }
  }

  @override
  Future<void> inProgressTaskUpdate(DataMap body) async {
    try {
      final urlParse = Uri.parse(ApiUrl.taskInProgressUpdateEndPoint);
      final token = SharedPrefs().getToken();
      final response = await _client.post(
        urlParse,
        headers: {'content-type': 'application/json', 'token': token},
        body: jsonEncode(body),
      );
      Logger().d(response.body);
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: "Network Error", statusCode: response.statusCode);
      }
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse["message"] != "Updated Successfully") {
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
  Future<void> initiatedTaskUpdate(DataMap body) async {
    try {
      final urlParse = Uri.parse(ApiUrl.taskInitiatedUpdateEndPoint);
      final token = SharedPrefs().getToken();
      final response = await _client.post(
        urlParse,
        headers: {'content-type': 'application/json', 'token': token},
        body: jsonEncode(body),
      );
      Logger().d(response.body);
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: "Network Error", statusCode: response.statusCode);
      }
    } on APIException {
      rethrow;
    } catch (e) {
      throw const APIException(message: "Network Error", statusCode: 505);
    }
  }

  @override
  Future<void> pendingTaskUpdate(DataMap body) async {
    try {
      final urlParse = Uri.parse(ApiUrl.taskPendingUpdateEndPoint);
      final token = SharedPrefs().getToken();
      final response = await _client.post(
        urlParse,
        headers: {'content-type': 'application/json', 'token': token},
        body: jsonEncode(body),
      );
      Logger().d(response.body);
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: "Network Error", statusCode: response.statusCode);
      }
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse["message"] != "Updated Successfully") {
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
  Future<TaskPlannerModel> statusBasedTask(String status, String search) async {
    try {
      final urlParse = Uri.parse(ApiUrl.taskPlannerTaskStatusEndPoint);
      final token = SharedPrefs().getToken();
      final response = await _client.get(
        urlParse,
        headers: {
          'content-type': 'application/json',
          'token': token,
          'status': status,
          'search': search
        },
      );
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: "Network Error", statusCode: response.statusCode);
      }
      Logger().d(response.body);
      final jsonResponse = jsonDecode(response.body);
      return TaskPlannerModel.fromJson(jsonResponse);
    } on APIException {
      rethrow;
    } catch (e) {
      Logger().e(e);
      throw const APIException(message: "Network Error", statusCode: 505);
    }
  }

  @override
  Future<void> testL1TaskUpdate(DataMap body) async {
    try {
      final urlParse = Uri.parse(ApiUrl.taskTestingL1UpdateEndPoint);
      final token = SharedPrefs().getToken();
      final response = await _client.post(
        urlParse,
        headers: {'content-type': 'application/json', 'token': token},
        body: jsonEncode(body),
      );
      Logger().d(response.body);
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: "Network Error", statusCode: response.statusCode);
      }
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse["message"] != "Updated Successfully") {
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
  Future<void> testL2TaskUpdate(DataMap body) async {
    try {
      final urlParse = Uri.parse(ApiUrl.taskTestingL2UpdateEndPoint);
      final token = SharedPrefs().getToken();
      final response = await _client.post(
        urlParse,
        headers: {'content-type': 'application/json', 'token': token},
        body: jsonEncode(body),
      );
      Logger().d(response.body);
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: "Network Error", statusCode: response.statusCode);
      }
    } on APIException {
      rethrow;
    } catch (e) {
      Logger().e(e);
      throw const APIException(message: "Network Error", statusCode: 505);
    }
  }

  @override
  Future<TaskPlannerModel> todayTask(String date) async {
    try {
      final urlParse = Uri.parse(ApiUrl.taskPlannerCommonEndPoint);
      final token = SharedPrefs().getToken();
      final response = await _client.get(
        urlParse,
        headers: {
          'content-type': 'application/json',
          'token': token,
          'date': date
        },
      );
      Logger().d(response.body);
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: "Network Error", statusCode: response.statusCode);
      }
      final jsonResponse = jsonDecode(response.body);
      return TaskPlannerModel.fromJson(jsonResponse);
    } on APIException {
      rethrow;
    } catch (e) {
      Logger().e(e);
      throw const APIException(message: "Network Error", statusCode: 505);
    }
  }

  @override
  Future<TaskReportModel> taskReport() async {
    try {
      final urlParse = Uri.parse(ApiUrl.taskPlannerReportEndPoint);
      final token = SharedPrefs().getToken();
      final response = await _client.get(
        urlParse,
        headers: {'content-type': 'application/json', 'token': token},
      );
      Logger().d(response.body);
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: "Network Error", statusCode: response.statusCode);
      }
      final jsonResponse = jsonDecode(response.body);
      return TaskReportModel.fromJson(jsonResponse);
    } on APIException {
      rethrow;
    } catch (e) {
      Logger().e(e);
      throw const APIException(message: "Network Error", statusCode: 505);
    }
  }

  @override
  Future<void> supportTask(DataMap body) async {
    try {
      final urlParse = Uri.parse(ApiUrl.supportTaskSaveEndPoint);
      final token = SharedPrefs().getToken();
      final response = await _client.post(
        urlParse,
        headers: {'content-type': 'application/json', 'token': token},
        body: jsonEncode(body),
      );
      Logger().d(response.body);
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: "Network Error", statusCode: response.statusCode);
      }
    } on APIException {
      rethrow;
    } catch (e) {
      Logger().e(e);
      throw const APIException(message: "Network Error", statusCode: 505);
    }
  }

  @override
  Future<ProjectModel> projectList() async {
    try {
      final urlParse = Uri.parse(ApiUrl.projectListEndPoint);
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
      return ProjectModel.fromJson(jsonResponse);
    } on APIException {
      rethrow;
    } catch (e) {
      Logger().e(e);
      throw const APIException(message: "Network Error", statusCode: 505);
    }
  }

  @override
  Future<DevTeamModel> teamList() async {
    try {
      final urlParse = Uri.parse(ApiUrl.teamListEndPoint);
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
      return DevTeamModel.fromJson(jsonResponse);
    } on APIException {
      rethrow;
    } catch (e) {
      Logger().e(e);
      throw const APIException(message: "Network Error", statusCode: 505);
    }
  }

  @override
  Future<ProjectTaskDropdownModel> projectTaskDropdown() async {
    try {
      final urlParse = Uri.parse(ApiUrl.projectTaskDropdownEndPoint);
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

      return ProjectTaskDropdownModel.fromJson(jsonResponse);
    } on APIException {
      rethrow;
    } catch (e) {
      throw const APIException(message: "Network Error", statusCode: 505);
    }
  }
}
