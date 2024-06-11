import 'dart:io';

import '../../../../core/core.dart';
import '../../account.dart';

abstract class AccountDataSource {
  Future<ProfileDetailModel> profileDetail();

  Future<void> profileEdit(DataMap body);

  Future<void> profileUpload(DataMap body);

  Future<CompetencyLevelModel> competencyLevel();

  Future<CertificateLevelModel> certificateLevel();

  Future<EducationLevelModel> educationLevel();

  Future<CountryModel> country();

  Future<StateModel> state(String countryId);

  Future<CityModel> city(String stateId);

  Future<ReligionModel> religion();

  Future<MotherTongueModel> motherTongue();

  Future<NationalityModel> nationality();

  Future<BloodGroupModel> bloodGroup();

  Future<void> skillInsert(DataMap body, File? file);

  Future<void> skillUpdate(DataMap body, File? file);

  Future<void> experienceSave(DataMap body, File? file);

  Future<void> educationSave(DataMap body, File? file);

  Future<void> contactSave(DataMap body);

  Future<void> personalSave(DataMap body);

  Future<void> trainingAndCertificationSave(DataMap body, File? file);

  Future<void> visaAndImmigrationSave(DataMap body, File? file);
}
