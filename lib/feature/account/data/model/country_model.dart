import '../../../../core/core.dart';

class CountryModel {
  List<CommonList>? country;

  CountryModel({this.country});

  CountryModel.fromJson(Map<String, dynamic> json) {
    if (json['country'] != null) {
      country = <CommonList>[];
      json['country'].forEach((v) {
        country!.add(CommonList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (country != null) {
      data['country'] = country!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
