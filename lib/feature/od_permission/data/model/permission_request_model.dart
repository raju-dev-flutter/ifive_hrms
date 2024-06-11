import '../../../../core/core.dart';

class PermissionRequestModel {
  List<CommonList>? request;

  PermissionRequestModel({this.request});

  PermissionRequestModel.fromJson(DataMap json) {
    if (json['requestbo'] != null) {
      request = <CommonList>[];
      json['requestbo'].forEach((v) {
        request!.add(CommonList.fromJson(v));
      });
    }
  }

  DataMap toJson() {
    final DataMap data = <String, dynamic>{};
    if (request != null) {
      data['requestbo'] = request!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
