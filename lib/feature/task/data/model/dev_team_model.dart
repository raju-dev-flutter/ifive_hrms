import 'package:ifive_hrms/core/core.dart';

class DevTeamModel {
  List<CommonList>? teamList;

  DevTeamModel({this.teamList});

  DevTeamModel.fromJson(Map<String, dynamic> json) {
    if (json['TLlsit'] != null) {
      teamList = <CommonList>[];
      json['TLlsit'].forEach((v) {
        teamList!.add(CommonList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (teamList != null) {
      data['TLlsit'] = teamList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
