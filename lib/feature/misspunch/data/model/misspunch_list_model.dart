import '../../../../core/core.dart';

class MisspunchListModel {
  List<CommonList>? misspunch;

  MisspunchListModel({this.misspunch});

  MisspunchListModel.fromJson(Map<String, dynamic> json) {
    if (json['misspunch'] != null) {
      misspunch = <CommonList>[];
      json['misspunch'].forEach((v) {
        misspunch!.add(CommonList.fromJson(v));
      });
    }
  }

  DataMap toJson() {
    final DataMap data = <String, dynamic>{};
    if (misspunch != null) {
      data['misspunch'] = misspunch!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
