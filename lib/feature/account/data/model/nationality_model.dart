import '../../../../core/core.dart';

class NationalityModel {
  List<CommonList>? nationality;

  NationalityModel({this.nationality});

  NationalityModel.fromJson(Map<String, dynamic> json) {
    if (json['nationality'] != null) {
      nationality = <CommonList>[];
      json['nationality'].forEach((v) {
        nationality!.add(CommonList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (nationality != null) {
      data['nationality'] = nationality!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
