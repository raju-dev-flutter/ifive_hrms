import 'package:ifive_hrms/core/core.dart';

class EmployeeModel {
  List<CommonList>? employeeList;

  EmployeeModel({this.employeeList});

  EmployeeModel.fromJson(Map<String, dynamic> json) {
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
