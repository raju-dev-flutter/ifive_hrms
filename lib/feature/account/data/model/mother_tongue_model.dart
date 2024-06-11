import '../../../../core/core.dart';

class MotherTongueModel {
  List<CommonList>? motherTongue;

  MotherTongueModel({this.motherTongue});

  MotherTongueModel.fromJson(Map<String, dynamic> json) {
    if (json['mothertongue'] != null) {
      motherTongue = <CommonList>[];
      json['mothertongue'].forEach((v) {
        motherTongue!.add(CommonList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (motherTongue != null) {
      data['mothertongue'] = motherTongue!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
