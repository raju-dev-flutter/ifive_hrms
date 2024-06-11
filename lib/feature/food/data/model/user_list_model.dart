class FoodAttendanceListModel {
  List<FoodCountList>? foodCountList;

  FoodAttendanceListModel({this.foodCountList});

  FoodAttendanceListModel.fromJson(Map<String, dynamic> json) {
    if (json['foodcountlist'] != null) {
      foodCountList = <FoodCountList>[];
      json['foodcountlist'].forEach((v) {
        foodCountList!.add(FoodCountList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (foodCountList != null) {
      data['foodcountlist'] = foodCountList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FoodCountList {
  String? createdAt;
  String? firstName;
  String? status;
  int? employeeId;
  String? finalStatus;
  int? count;

  FoodCountList(
      {this.createdAt,
      this.firstName,
      this.status,
      this.employeeId,
      this.finalStatus,
      this.count});

  FoodCountList.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'];
    firstName = json['first_name'];
    status = json['status'];
    employeeId = json['employee_id'];
    finalStatus = json['final_status'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['created_at'] = createdAt;
    data['first_name'] = firstName;
    data['status'] = status;
    data['employee_id'] = employeeId;
    data['final_status'] = finalStatus;
    data['count'] = count;
    return data;
  }
}
