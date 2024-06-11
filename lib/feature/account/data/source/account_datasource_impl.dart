import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../../../../core/core.dart';
import '../../account.dart';

class AccountDataSourceImpl implements AccountDataSource {
  const AccountDataSourceImpl(this._client);

  final http.Client _client;

  @override
  Future<ProfileDetailModel> profileDetail() async {
    try {
      final urlParse = Uri.parse(ApiUrl.profileDetailEndPoint);
      final token = SharedPrefs().getToken();
      final response = await _client.post(urlParse,
          headers: {'content-type': 'application/json', 'token': token});
      Logger().i(response.body);
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: "No Internet Connection", statusCode: response.statusCode);
      }
      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse == null) {
        throw APIException(
            message: "No Internet Connection", statusCode: response.statusCode);
      }

      return ProfileDetailModel.fromJson(jsonResponse);
    } on APIException {
      rethrow;
    } catch (e) {
      Logger().e(e.toString());
      throw const APIException(
          message: "No Internet Connection", statusCode: 505);
    }
  }

  @override
  Future<void> profileEdit(DataMap body) async {
    Logger().i("Profile Edit");
    try {
      final urlParse = Uri.parse(ApiUrl.profileEditEndPoint);
      final token = SharedPrefs().getToken();
      final response = await _client.post(
        urlParse,
        headers: {'content-type': 'application/json', 'token': token},
        body: jsonEncode(body),
      );

      final jsonResponse = jsonDecode(response.body);

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: "No Internet Connection", statusCode: response.statusCode);
      }
      if (jsonResponse == null) {
        throw APIException(
            message: "No Internet Connection", statusCode: response.statusCode);
      }
    } on APIException {
      rethrow;
    } catch (e) {
      throw const APIException(
          message: "No Internet Connection", statusCode: 505);
    }
  }

  @override
  Future<void> profileUpload(DataMap body) async {
    try {
      final urlParse = Uri.parse(ApiUrl.profileUploadEndPoint);
      final token = SharedPrefs().getToken();
      final response = await _client.post(
        urlParse,
        headers: {'content-type': 'application/json', 'token': token},
        body: jsonEncode(body),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: "No Internet Connection", statusCode: response.statusCode);
      }
      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse == null) {
        throw APIException(
            message: "No Internet Connection", statusCode: response.statusCode);
      }
      Logger().t(jsonResponse.toString());
    } on APIException {
      rethrow;
    } catch (e) {
      throw const APIException(
          message: "No Internet Connection", statusCode: 505);
    }
  }

  @override
  Future<CompetencyLevelModel> competencyLevel() async {
    try {
      final urlParse = Uri.parse(ApiUrl.competencyLevelEndPoint);
      final token = SharedPrefs().getToken();
      final response = await _client.post(urlParse,
          headers: {'content-type': 'application/json', 'token': token});

      if (response.statusCode != 200 && response.statusCode != 201) {
        Logger().t(response.body.toString());
        throw APIException(
            message: "No Internet Connection", statusCode: response.statusCode);
      }
      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse == null) {
        throw APIException(
            message: "No Internet Connection", statusCode: response.statusCode);
      }
      return CompetencyLevelModel.fromJson(jsonResponse);
    } on APIException {
      rethrow;
    } catch (e) {
      throw const APIException(
          message: "No Internet Connection", statusCode: 505);
    }
  }

  @override
  Future<EducationLevelModel> educationLevel() async {
    try {
      final urlParse = Uri.parse(ApiUrl.educationLevelEndPoint);
      final token = SharedPrefs().getToken();
      final response = await _client.post(urlParse,
          headers: {'content-type': 'application/json', 'token': token});

      if (response.statusCode != 200 && response.statusCode != 201) {
        Logger().t(response.body.toString());
        throw APIException(
            message: "No Internet Connection", statusCode: response.statusCode);
      }
      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse == null) {
        throw APIException(
            message: "No Internet Connection", statusCode: response.statusCode);
      }
      return EducationLevelModel.fromJson(jsonResponse);
    } on APIException {
      rethrow;
    } catch (e) {
      throw const APIException(
          message: "No Internet Connection", statusCode: 505);
    }
  }

  @override
  Future<CountryModel> country() async {
    try {
      final urlParse = Uri.parse(ApiUrl.countryEndPoint);
      final token = SharedPrefs().getToken();
      final response = await _client.post(urlParse,
          headers: {'content-type': 'application/json', 'token': token});

      if (response.statusCode != 200 && response.statusCode != 201) {
        Logger().t(response.body.toString());
        throw APIException(
            message: "No Internet Connection", statusCode: response.statusCode);
      }
      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse == null) {
        throw APIException(
            message: "No Internet Connection", statusCode: response.statusCode);
      }
      return CountryModel.fromJson(jsonResponse);
    } on APIException {
      rethrow;
    } catch (e) {
      throw const APIException(
          message: "No Internet Connection", statusCode: 505);
    }
  }

  @override
  Future<StateModel> state(String countryId) async {
    try {
      final urlParse = Uri.parse(ApiUrl.stateEndPoint);
      final token = SharedPrefs().getToken();
      final headers = {
        'content-type': 'application/json',
        'token': token,
        'countryid': countryId
      };
      final response = await _client.post(urlParse, headers: headers);

      if (response.statusCode != 200 && response.statusCode != 201) {
        Logger().t(response.body.toString());
        throw APIException(
            message: "No Internet Connection", statusCode: response.statusCode);
      }
      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse == null) {
        throw APIException(
            message: "No Internet Connection", statusCode: response.statusCode);
      }
      return StateModel.fromJson(jsonResponse);
    } on APIException {
      rethrow;
    } catch (e) {
      throw const APIException(
          message: "No Internet Connection", statusCode: 505);
    }
  }

  @override
  Future<CityModel> city(String stateId) async {
    try {
      final urlParse = Uri.parse(ApiUrl.cityEndPoint);
      final token = SharedPrefs().getToken();
      final headers = {
        'content-type': 'application/json',
        'token': token,
        'stateid': stateId
      };
      final response = await _client.post(urlParse, headers: headers);

      if (response.statusCode != 200 && response.statusCode != 201) {
        Logger().t(response.body.toString());
        throw APIException(
            message: "No Internet Connection", statusCode: response.statusCode);
      }
      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse == null) {
        throw APIException(
            message: "No Internet Connection", statusCode: response.statusCode);
      }
      return CityModel.fromJson(jsonResponse);
    } on APIException {
      rethrow;
    } catch (e) {
      throw const APIException(
          message: "No Internet Connection", statusCode: 505);
    }
  }

  @override
  Future<MotherTongueModel> motherTongue() async {
    try {
      final urlParse = Uri.parse(ApiUrl.motherTongueEndPoint);
      final token = SharedPrefs().getToken();
      final response = await _client.post(urlParse,
          headers: {'content-type': 'application/json', 'token': token});

      if (response.statusCode != 200 && response.statusCode != 201) {
        Logger().t(response.body.toString());
        throw APIException(
            message: "No Internet Connection", statusCode: response.statusCode);
      }
      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse == null) {
        throw APIException(
            message: "No Internet Connection", statusCode: response.statusCode);
      }
      return MotherTongueModel.fromJson(jsonResponse);
    } on APIException {
      rethrow;
    } catch (e) {
      throw const APIException(
          message: "No Internet Connection", statusCode: 505);
    }
  }

  @override
  Future<NationalityModel> nationality() async {
    try {
      final urlParse = Uri.parse(ApiUrl.nationalityEndPoint);
      final token = SharedPrefs().getToken();
      final response = await _client.post(urlParse,
          headers: {'content-type': 'application/json', 'token': token});

      if (response.statusCode != 200 && response.statusCode != 201) {
        Logger().t(response.body.toString());
        throw APIException(
            message: "No Internet Connection", statusCode: response.statusCode);
      }
      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse == null) {
        throw APIException(
            message: "No Internet Connection", statusCode: response.statusCode);
      }
      return NationalityModel.fromJson(jsonResponse);
    } on APIException {
      rethrow;
    } catch (e) {
      throw const APIException(
          message: "No Internet Connection", statusCode: 505);
    }
  }

  @override
  Future<BloodGroupModel> bloodGroup() async {
    try {
      final urlParse = Uri.parse(ApiUrl.bloodGroupEndPoint);
      final token = SharedPrefs().getToken();
      final response = await _client.post(urlParse,
          headers: {'content-type': 'application/json', 'token': token});

      if (response.statusCode != 200 && response.statusCode != 201) {
        Logger().t(response.body.toString());
        throw APIException(
            message: "No Internet Connection", statusCode: response.statusCode);
      }
      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse == null) {
        throw APIException(
            message: "No Internet Connection", statusCode: response.statusCode);
      }
      return BloodGroupModel.fromJson(jsonResponse);
    } on APIException {
      rethrow;
    } catch (e) {
      throw const APIException(
          message: "No Internet Connection", statusCode: 505);
    }
  }

  @override
  Future<ReligionModel> religion() async {
    try {
      final urlParse = Uri.parse(ApiUrl.religionEndPoint);
      final token = SharedPrefs().getToken();
      final response = await _client.post(urlParse,
          headers: {'content-type': 'application/json', 'token': token});

      if (response.statusCode != 200 && response.statusCode != 201) {
        Logger().t(response.body.toString());
        throw APIException(
            message: "No Internet Connection", statusCode: response.statusCode);
      }
      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse == null) {
        throw APIException(
            message: "No Internet Connection", statusCode: response.statusCode);
      }
      return ReligionModel.fromJson(jsonResponse);
    } on APIException {
      rethrow;
    } catch (e) {
      throw const APIException(
          message: "No Internet Connection", statusCode: 505);
    }
  }

  @override
  Future<void> contactSave(DataMap body) async {
    try {
      final urlParse = Uri.parse(ApiUrl.contactSaveEndPoint);
      final token = SharedPrefs().getToken();
      final response = await _client.post(
        urlParse,
        headers: {'content-type': 'application/json', 'token': token},
        body: jsonEncode(body),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: "No Internet Connection", statusCode: response.statusCode);
      }
      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse == null) {
        throw APIException(
            message: "No Internet Connection", statusCode: response.statusCode);
      }
    } on APIException {
      rethrow;
    } catch (e) {
      throw const APIException(
          message: "No Internet Connection", statusCode: 505);
    }
  }

  @override
  Future<void> educationSave(DataMap body, File? file) async {
    try {
      // final urlParse = Uri.parse(ApiUrl.educationSaveEndPoint);
      final urlParse = Uri.parse(ApiUrl.educationSaveEndPoint);
      var request = http.MultipartRequest('POST', urlParse);

      request.headers['content-type'] = 'application/json';
      request.headers['token'] = SharedPrefs().getToken();
      request.fields['result'] = jsonEncode(body);

      if (file != null) {
        request.files.add(await http.MultipartFile.fromPath('file', file.path));
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      Logger().d(response.body);
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: "No Internet Connection", statusCode: response.statusCode);
      }
      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse == null) {
        throw APIException(
            message: "No Internet Connection", statusCode: response.statusCode);
      }
    } on APIException {
      rethrow;
    } catch (e) {
      Logger().e(e);
      throw const APIException(
          message: "No Internet Connection", statusCode: 505);
    }
  }

  @override
  Future<void> experienceSave(DataMap body, File? file) async {
    try {
      final urlParse = Uri.parse(ApiUrl.experienceSaveEndPoint);
      var request = http.MultipartRequest('POST', urlParse);

      request.headers['content-type'] = 'application/json';
      request.headers['token'] = SharedPrefs().getToken();
      request.fields['result'] = jsonEncode(body);

      if (file != null) {
        request.files.add(await http.MultipartFile.fromPath('file', file.path));
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      Logger().i(response.body);
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: "No Internet Connection", statusCode: response.statusCode);
      }
      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse == null) {
        throw APIException(
            message: "No Internet Connection", statusCode: response.statusCode);
      }
    } on APIException {
      rethrow;
    } catch (e) {
      Logger().e(e);
      throw const APIException(
          message: "No Internet Connection", statusCode: 505);
    }
  }

  @override
  Future<void> skillInsert(DataMap body, File? file) async {
    try {
      final urlParse = Uri.parse(ApiUrl.skillInsertEndPoint);
      var request = http.MultipartRequest('POST', urlParse);

      request.headers['content-type'] = 'application/json';
      request.headers['token'] = SharedPrefs().getToken();
      request.fields['result'] = jsonEncode(body);

      if (file != null) {
        request.files.add(await http.MultipartFile.fromPath('file', file.path));
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      Logger().i(response.body);
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: "No Internet Connection", statusCode: response.statusCode);
      }
      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse == null) {
        throw APIException(
            message: "No Internet Connection", statusCode: response.statusCode);
      }
    } on APIException {
      rethrow;
    } catch (e) {
      throw const APIException(
          message: "No Internet Connection", statusCode: 505);
    }
  }

  @override
  Future<void> skillUpdate(DataMap body, File? file) async {
    try {
      final urlParse = Uri.parse(ApiUrl.skillUpdateEndPoint);
      var request = http.MultipartRequest('POST', urlParse);

      request.headers['content-type'] = 'application/json';
      request.headers['token'] = SharedPrefs().getToken();
      request.fields['result'] = jsonEncode(body);

      if (file != null) {
        request.files.add(await http.MultipartFile.fromPath('file', file.path));
      }
      //
      // if (files != null) {
      //   for (var file in files) {
      //     request.files.add(
      //       await http.MultipartFile.fromPath('files[]', file.path),
      //     );
      //   }
      // }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: "No Internet Connection", statusCode: response.statusCode);
      }
      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse == null) {
        throw APIException(
            message: "No Internet Connection", statusCode: response.statusCode);
      }
    } on APIException {
      rethrow;
    } catch (e) {
      throw const APIException(
          message: "No Internet Connection", statusCode: 505);
    }
  }

  @override
  Future<void> personalSave(DataMap body) async {
    try {
      final urlParse = Uri.parse(ApiUrl.personalSaveEndPoint);
      final token = SharedPrefs().getToken();
      final response = await _client.post(
        urlParse,
        headers: {'content-type': 'application/json', 'token': token},
        body: jsonEncode(body),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: "No Internet Connection", statusCode: response.statusCode);
      }
      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse == null) {
        throw APIException(
            message: "No Internet Connection", statusCode: response.statusCode);
      }
    } on APIException {
      rethrow;
    } catch (e) {
      throw const APIException(
          message: "No Internet Connection", statusCode: 505);
    }
  }

  @override
  Future<void> trainingAndCertificationSave(DataMap body, File? file) async {
    try {
      final urlParse = Uri.parse(ApiUrl.trainingAndCertificationSaveEndPoint);
      var request = http.MultipartRequest('POST', urlParse);

      request.headers['content-type'] = 'application/json';
      request.headers['token'] = SharedPrefs().getToken();
      request.fields['result'] = jsonEncode(body);

      if (file != null) {
        request.files.add(await http.MultipartFile.fromPath('file', file.path));
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      Logger().i(response.body);
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: "No Internet Connection", statusCode: response.statusCode);
      }
      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse == null) {
        throw APIException(
            message: "No Internet Connection", statusCode: response.statusCode);
      }
    } on APIException {
      rethrow;
    } catch (e) {
      throw const APIException(
          message: "No Internet Connection", statusCode: 505);
    }
  }

  @override
  Future<void> visaAndImmigrationSave(DataMap body, File? file) async {
    try {
      final urlParse = Uri.parse(ApiUrl.visaAndImmigrationSaveEndPoint);
      var request = http.MultipartRequest('POST', urlParse);

      request.headers['content-type'] = 'application/json';
      request.headers['token'] = SharedPrefs().getToken();
      request.fields['result'] = jsonEncode(body);

      if (file != null) {
        request.files.add(await http.MultipartFile.fromPath('file', file.path));
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      Logger().i(response.body);
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: "No Internet Connection", statusCode: response.statusCode);
      }
      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse == null) {
        throw APIException(
            message: "No Internet Connection", statusCode: response.statusCode);
      }
    } on APIException {
      rethrow;
    } catch (e) {
      throw const APIException(
          message: "No Internet Connection", statusCode: 505);
    }
  }

  @override
  Future<CertificateLevelModel> certificateLevel() async {
    try {
      final urlParse = Uri.parse(ApiUrl.certificateLevelEndPoint);
      final token = SharedPrefs().getToken();
      final response = await _client.post(urlParse,
          headers: {'content-type': 'application/json', 'token': token});

      if (response.statusCode != 200 && response.statusCode != 201) {
        Logger().t(response.body.toString());
        throw APIException(
            message: "No Internet Connection", statusCode: response.statusCode);
      }
      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse == null) {
        throw APIException(
            message: "No Internet Connection", statusCode: response.statusCode);
      }
      return CertificateLevelModel.fromJson(jsonResponse);
    } on APIException {
      rethrow;
    } catch (e) {
      throw const APIException(
          message: "No Internet Connection", statusCode: 505);
    }
  }
}
