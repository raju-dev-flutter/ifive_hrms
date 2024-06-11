class OverAllAttendanceModel {
  List<OverallAttendance>? overallAttendance;

  OverAllAttendanceModel({this.overallAttendance});

  OverAllAttendanceModel.fromJson(Map<String, dynamic> json) {
    if (json['overallAttendance'] != null) {
      overallAttendance = <OverallAttendance>[];
      json['overallAttendance'].forEach((v) {
        overallAttendance!.add(OverallAttendance.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (overallAttendance != null) {
      data['overallAttendance'] =
          overallAttendance!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OverallAttendance {
  String? sTimestamp;
  String? eTimestamp;
  String? attendanceDate;
  int? employeeAttendanceId;
  String? employeeName;
  String? attendanceStatus;
  String? lastSeen;

  OverallAttendance(
      {this.sTimestamp,
      this.eTimestamp,
      this.attendanceDate,
      this.employeeAttendanceId,
      this.employeeName,
      this.attendanceStatus,
      this.lastSeen});

  OverallAttendance.fromJson(Map<String, dynamic> json) {
    sTimestamp = json['s_timestamp'];
    eTimestamp = json['e_timestamp'];
    attendanceDate = json['atten_date'];
    employeeAttendanceId = json['employee_attendance_id'];
    employeeName = json['employee_name'];
    attendanceStatus = json['attendance_status'];
    lastSeen = json['last_seen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['s_timestamp'] = sTimestamp;
    data['e_timestamp'] = eTimestamp;
    data['atten_date'] = attendanceDate;
    data['employee_attendance_id'] = employeeAttendanceId;
    data['employee_name'] = employeeName;
    data['attendance_status'] = attendanceStatus;
    data['last_seen'] = lastSeen;
    return data;
  }
}
