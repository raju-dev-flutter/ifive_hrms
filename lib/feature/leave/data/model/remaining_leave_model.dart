import '../../../../core/core.dart';

class RemainingLeaveModel {
  dynamic remainingDays;

  RemainingLeaveModel({this.remainingDays});

  RemainingLeaveModel.fromJson(DataMap json) {
    remainingDays = json['remaining_days'];
  }

  Map<String, dynamic> toJson() {
    final DataMap data = <String, dynamic>{};
    data['remaining_days'] = remainingDays;
    return data;
  }
}
