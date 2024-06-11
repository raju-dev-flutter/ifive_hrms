import 'dart:io';

import '../../../../core/core.dart';
import '../../account.dart';

abstract class AccountRepository {
  ResultFuture<ProfileDetailModel> profileDetail();

  ResultVoid profileUpload(DataMap body);

  ResultVoid profileEdit(DataMap body);

  ResultFuture<CompetencyLevelModel> competencyLevel();

  ResultFuture<CertificateLevelModel> certificateLevel();

  ResultFuture<EducationLevelModel> educationLevel();

  ResultFuture<CountryModel> country();

  ResultFuture<StateModel> state(String countryId);

  ResultFuture<CityModel> city(String stateId);

  ResultFuture<ReligionModel> religion();

  ResultFuture<MotherTongueModel> motherTongue();

  ResultFuture<NationalityModel> nationality();

  ResultFuture<BloodGroupModel> bloodGroup();

  ResultVoid skillInsert(DataMap body, File? file);

  ResultVoid skillUpdate(DataMap body, File? file);

  ResultVoid experienceSave(DataMap body, File? file);

  ResultVoid educationSave(DataMap body, File? file);

  ResultVoid contactSave(DataMap body);

  ResultVoid personalSave(DataMap body);

  ResultVoid trainingAndCertificationSave(DataMap body, File? file);

  ResultVoid visaAndImmigrationSave(DataMap body, File? file);
}
