import '../../../../core/core.dart';

class CompetencyLevelModel {
  List<CommonList>? competencyLevel;

  CompetencyLevelModel({this.competencyLevel});

  CompetencyLevelModel.fromJson(Map<String, dynamic> json) {
    if (json['competency_level'] != null) {
      competencyLevel = <CommonList>[];
      json['competency_level'].forEach((v) {
        competencyLevel!.add(CommonList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (competencyLevel != null) {
      data['competency_level'] =
          competencyLevel!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
