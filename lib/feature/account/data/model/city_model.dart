import '../../../../core/core.dart';

class CityModel {
  List<CommonList>? city;

  CityModel({this.city});

  CityModel.fromJson(Map<String, dynamic> json) {
    if (json['city'] != null) {
      city = <CommonList>[];
      json['city'].forEach((v) {
        city!.add(CommonList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (city != null) {
      data['city'] = city!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
