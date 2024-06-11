class AttendanceUserListModel {
  List<UserList>? userList;

  AttendanceUserListModel({this.userList});

  AttendanceUserListModel.fromJson(Map<String, dynamic> json) {
    if (json['userlist'] != null) {
      userList = <UserList>[];
      json['userlist'].forEach((v) {
        userList!.add(UserList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (userList != null) {
      data['userlist'] = userList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserList {
  int? type;
  int? id;
  String? active;
  String? taskDesc;
  String? sTimestamp;
  int? employeeId;
  String? sTime;
  String? eTimestamp;
  String? timetaken;
  String? firstName;

  UserList(
      {this.type,
      this.id,
      this.active,
      this.taskDesc,
      this.sTimestamp,
      this.employeeId,
      this.sTime,
      this.eTimestamp,
      this.timetaken,
      this.firstName});

  UserList.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    id = json['id'];
    active = json['active'];
    taskDesc = json['task_desc'];
    sTimestamp = json['s_timestamp'];
    employeeId = json['employee_id'];
    sTime = json['s_time'];
    eTimestamp = json['e_timestamp'];
    timetaken = json['timetaken'];
    firstName = json['first_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['id'] = id;
    data['active'] = active;
    data['task_desc'] = taskDesc;
    data['s_timestamp'] = sTimestamp;
    data['employee_id'] = employeeId;
    data['s_time'] = sTime;
    data['e_timestamp'] = eTimestamp;
    data['timetaken'] = timetaken;
    data['first_name'] = firstName;
    return data;
  }
}
