import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../account.dart';

class AccountRepositoryImpl implements AccountRepository {
  const AccountRepositoryImpl(this._datasource);

  final AccountDataSource _datasource;

  @override
  ResultFuture<ProfileDetailModel> profileDetail() async {
    try {
      final profileResponse = await _datasource.profileDetail();
      return Right(profileResponse);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultVoid profileEdit(DataMap body) async {
    try {
      final editResponse = await _datasource.profileEdit(body);
      return Right(editResponse);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultVoid profileUpload(DataMap body) async {
    try {
      final uploadResponse = await _datasource.profileUpload(body);
      return Right(uploadResponse);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<CompetencyLevelModel> competencyLevel() async {
    try {
      final response = await _datasource.competencyLevel();
      return Right(response);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<EducationLevelModel> educationLevel() async {
    try {
      final response = await _datasource.educationLevel();
      return Right(response);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<CountryModel> country() async {
    try {
      final response = await _datasource.country();
      return Right(response);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<StateModel> state(String countryId) async {
    try {
      final response = await _datasource.state(countryId);
      return Right(response);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<CityModel> city(String stateId) async {
    try {
      final response = await _datasource.city(stateId);
      return Right(response);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<MotherTongueModel> motherTongue() async {
    try {
      final response = await _datasource.motherTongue();
      return Right(response);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<NationalityModel> nationality() async {
    try {
      final response = await _datasource.nationality();
      return Right(response);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<ReligionModel> religion() async {
    try {
      final response = await _datasource.religion();
      return Right(response);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultVoid contactSave(DataMap body) async {
    try {
      final response = await _datasource.contactSave(body);
      return Right(response);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultVoid educationSave(DataMap body, File? file) async {
    try {
      final response = await _datasource.educationSave(body, file);
      return Right(response);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultVoid experienceSave(DataMap body, File? file) async {
    try {
      final response = await _datasource.experienceSave(body, file);
      return Right(response);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultVoid skillInsert(DataMap body, File? file) async {
    try {
      final response = await _datasource.skillInsert(body, file);
      return Right(response);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultVoid skillUpdate(DataMap body, File? file) async {
    try {
      final response = await _datasource.skillUpdate(body, file);
      return Right(response);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<BloodGroupModel> bloodGroup() async {
    try {
      final response = await _datasource.bloodGroup();
      return Right(response);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultVoid personalSave(DataMap body) async {
    try {
      final response = await _datasource.personalSave(body);
      return Right(response);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultVoid trainingAndCertificationSave(DataMap body, File? file) async {
    try {
      final response =
          await _datasource.trainingAndCertificationSave(body, file);
      return Right(response);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultVoid visaAndImmigrationSave(DataMap body, File? file) async {
    try {
      final response = await _datasource.visaAndImmigrationSave(body, file);
      return Right(response);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<CertificateLevelModel> certificateLevel() async {
    try {
      final response = await _datasource.certificateLevel();
      return Right(response);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }
}
