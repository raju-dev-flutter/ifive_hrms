import '../../../../core/core.dart';

class MisspunchForwardListModel {
  String? id;
  String? level;
  String? type;
  String? empName;
  List<CommonList>? forwardList;

  MisspunchForwardListModel(
      {this.id, this.level, this.type, this.empName, this.forwardList});

  MisspunchForwardListModel.fromJson(DataMap json) {
    id = json['id'];
    level = json['level'];
    type = json['type'];
    empName = json['emp_name'];
    if (json['employee_name'] != null) {
      forwardList = <CommonList>[];
      json['employee_name'].forEach((v) {
        forwardList!.add(CommonList.fromJson(v));
      });
    }
  }

  DataMap toJson() {
    final DataMap data = <String, dynamic>{};
    data['id'] = id;
    data['level'] = level;
    data['type'] = type;
    data['emp_name'] = empName;
    if (forwardList != null) {
      data['employee_name'] = forwardList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
