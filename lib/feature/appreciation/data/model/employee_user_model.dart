import '../../../../core/core.dart';

class EmployeeUserModel {
  List<CommonList>? employeeList;

  EmployeeUserModel({this.employeeList});

  EmployeeUserModel.fromJson(Map<String, dynamic> json) {
    if (json['employee_list'] != null) {
      employeeList = <CommonList>[];
      json['employee_list'].forEach((v) {
        employeeList!.add(CommonList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (employeeList != null) {
      data['employee_list'] = employeeList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
