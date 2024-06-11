import '../../../../core/core.dart';

class EducationLevelModel {
  List<CommonList>? educationLevel;

  EducationLevelModel({this.educationLevel});

  EducationLevelModel.fromJson(Map<String, dynamic> json) {
    if (json['education_level'] != null) {
      educationLevel = <CommonList>[];
      json['education_level'].forEach((v) {
        educationLevel!.add(CommonList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (educationLevel != null) {
      data['education_level'] = educationLevel!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
