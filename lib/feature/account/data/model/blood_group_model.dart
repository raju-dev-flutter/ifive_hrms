import '../../../../core/core.dart';

class BloodGroupModel {
  List<CommonList>? bloodGroup;

  BloodGroupModel({this.bloodGroup});

  BloodGroupModel.fromJson(Map<String, dynamic> json) {
    if (json['blood_group'] != null) {
      bloodGroup = <CommonList>[];
      json['blood_group'].forEach((v) {
        bloodGroup!.add(CommonList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (bloodGroup != null) {
      data['blood_group'] = bloodGroup!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
