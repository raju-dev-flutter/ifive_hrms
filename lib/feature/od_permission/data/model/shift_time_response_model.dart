import '../../../../core/core.dart';

class ShiftTimeResponseModel {
  List<CommonList>? shiftTime;

  ShiftTimeResponseModel({this.shiftTime});

  ShiftTimeResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['shifttime'] != null) {
      shiftTime = <CommonList>[];
      json['shifttime'].forEach((v) {
        shiftTime!.add(CommonList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (shiftTime != null) {
      data['shifttime'] = shiftTime!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
