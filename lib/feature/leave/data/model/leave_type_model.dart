import '../../../../core/core.dart';

class LeaveTypeModel {
  List<CommonList>? leaveType;

  LeaveTypeModel({this.leaveType});

  LeaveTypeModel.fromJson(DataMap json) {
    if (json['leavetype'] != null) {
      leaveType = <CommonList>[];
      json['leavetype'].forEach((v) {
        leaveType!.add(CommonList.fromJson(v));
      });
    }
  }

  DataMap toJson() {
    final DataMap data = <String, dynamic>{};
    if (leaveType != null) {
      data['leavetype'] = leaveType!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
