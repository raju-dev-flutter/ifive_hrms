class AttendanceReportModel {
  List<AttendanceReport>? punchHistory;

  AttendanceReportModel({this.punchHistory});

  AttendanceReportModel.fromJson(Map<String, dynamic> json) {
    if (json['punchhistory'] != null) {
      punchHistory = <AttendanceReport>[];
      json['punchhistory'].forEach((v) {
        punchHistory!.add(AttendanceReport.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (punchHistory != null) {
      data['punchhistory'] = punchHistory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AttendanceReport {
  String? attenDate;
  String? checkIn;
  String? checkOut;
  String? workingHours;

  AttendanceReport(
      {this.attenDate, this.checkIn, this.checkOut, this.workingHours});

  AttendanceReport.fromJson(Map<String, dynamic> json) {
    attenDate = json['atten_date'];
    checkIn = json['check_in'];
    checkOut = json['check_out'];
    workingHours = json['working_hours'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['atten_date'] = attenDate;
    data['check_in'] = checkIn;
    data['check_out'] = checkOut;
    data['working_hours'] = workingHours;
    return data;
  }
}

// class AttendanceReportModel {
//   List<AttendanceReport>? employeeAttendanceList;
//
//   AttendanceReportModel({this.employeeAttendanceList});
//
//   AttendanceReportModel.fromJson(Map<String, dynamic> json) {
//     if (json['userlist'] != null) {
//       employeeAttendanceList = <AttendanceReport>[];
//       json['userlist'].forEach((v) {
//         employeeAttendanceList!.add(AttendanceReport.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (employeeAttendanceList != null) {
//       data['userlist'] =
//           employeeAttendanceList!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class AttendanceReport {
//   String? firstName;
//   String? type;
//   String? taskDesc;
//   String? timetaken;
//   String? sTimestamp;
//   String? eTimestamp;
//   String? dateEmployeeAttendanceTblSTimestamp;
//
//   AttendanceReport(
//       {this.firstName,
//       this.type,
//       this.taskDesc,
//       this.timetaken,
//       this.sTimestamp,
//       this.eTimestamp,
//       this.dateEmployeeAttendanceTblSTimestamp});
//
//   AttendanceReport.fromJson(Map<String, dynamic> json) {
//     firstName = json['first_name'];
//     type = json['type'];
//     taskDesc = json['task_desc'];
//     timetaken = json['timetaken'];
//     sTimestamp = json['s_timestamp'];
//     eTimestamp = json['e_timestamp'];
//     dateEmployeeAttendanceTblSTimestamp =
//         json['date(employee_attendance_tbl.s_timestamp)'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['first_name'] = firstName;
//     data['type'] = type;
//     data['task_desc'] = taskDesc;
//     data['timetaken'] = timetaken;
//     data['s_timestamp'] = sTimestamp;
//     data['e_timestamp'] = eTimestamp;
//     data['date(employee_attendance_tbl.s_timestamp)'] =
//         dateEmployeeAttendanceTblSTimestamp;
//     return data;
//   }
// }
