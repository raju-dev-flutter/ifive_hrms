import '../../../../core/core.dart';

class LeaveModeModel {
  List<CommonList>? leaveMode;

  LeaveModeModel({this.leaveMode});

  LeaveModeModel.fromJson(DataMap json) {
    if (json['leavemode'] != null) {
      leaveMode = <CommonList>[];
      json['leavemode'].forEach((v) {
        leaveMode!.add(CommonList.fromJson(v));
      });
    }
  }

  DataMap toJson() {
    final DataMap data = <String, dynamic>{};
    if (leaveMode != null) {
      data['leavemode'] = leaveMode!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
