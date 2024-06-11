import '../../../../core/core.dart';

class ReligionModel {
  List<CommonList>? religion;

  ReligionModel({this.religion});

  ReligionModel.fromJson(Map<String, dynamic> json) {
    if (json['religion'] != null) {
      religion = <CommonList>[];
      json['religion'].forEach((v) {
        religion!.add(CommonList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (religion != null) {
      data['religion'] = religion!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
