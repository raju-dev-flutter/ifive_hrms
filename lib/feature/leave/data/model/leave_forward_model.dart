import '../../../../core/core.dart';

class LeaveForwardModel {
  String? id;
  String? level;
  String? type;
  String? empName;
  List<CommonList>? employeeName;

  LeaveForwardModel(
      {this.id, this.level, this.type, this.empName, this.employeeName});

  LeaveForwardModel.fromJson(DataMap json) {
    id = json['id'];
    level = json['level'];
    type = json['type'];
    empName = json['emp_name'];
    if (json['employee_list'] != null) {
      employeeName = <CommonList>[];
      json['employee_list'].forEach((v) {
        employeeName!.add(CommonList.fromJson(v));
      });
    }
  }

  DataMap toJson() {
    final DataMap data = <String, dynamic>{};
    data['id'] = id;
    data['level'] = level;
    data['type'] = type;
    data['emp_name'] = empName;
    if (employeeName != null) {
      data['employee_list'] = employeeName!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
