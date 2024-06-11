import 'package:ifive_hrms/core/core.dart';

class CertificateLevelModel {
  List<CommonList>? certificateLevel;

  CertificateLevelModel({this.certificateLevel});

  CertificateLevelModel.fromJson(Map<String, dynamic> json) {
    if (json['certificate_level'] != null) {
      certificateLevel = <CommonList>[];
      json['certificate_level'].forEach((v) {
        certificateLevel!.add(CommonList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (certificateLevel != null) {
      data['certificate_level'] =
          certificateLevel!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
