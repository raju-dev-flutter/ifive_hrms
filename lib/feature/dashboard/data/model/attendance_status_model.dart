import 'dart:convert';

import '../../../../core/core.dart';
import '../../../attendance/attendance.dart';

class AttendanceStatusModel extends AttendanceStatus {
  const AttendanceStatusModel({
    required super.employeeLogId,
    required super.employeeId,
    required super.loginStatus,
    required super.sTimestamp,
    required super.date,
    required super.sLatitude,
    required super.sLongitude,
    required super.sBattery,
    required super.eTimestamp,
    required super.eBattery,
    required super.deleteStatus,
    required super.createdOn,
    required super.createdBy,
    required super.updatedOn,
    required super.updatedBy,
    required super.locId,
    required super.orgId,
    required super.cmpyId,
  });

  const AttendanceStatusModel.empty()
      : this(
          employeeLogId: 0,
          employeeId: 0,
          loginStatus: 0,
          sTimestamp: '_empty.sTimestamp',
          date: '_empty.date',
          sLatitude: '0.0',
          sLongitude: '0.0',
          sBattery: 1,
          eTimestamp: '_empty.eTimestamp',
          eBattery: 1,
          deleteStatus: 1,
          createdOn: '_empty.createdOn',
          createdBy: 1,
          updatedOn: '_empty.updatedOn',
          updatedBy: 1,
          locId: 1,
          orgId: 1,
          cmpyId: 1,
        );

  factory AttendanceStatusModel.fromJson(String source) =>
      AttendanceStatusModel.fromMap(jsonDecode(source) as DataMap);

  AttendanceStatusModel.fromMap(DataMap map)
      : this(
          employeeLogId: map['employee_log_id'],
          employeeId: map['employee_id'],
          loginStatus: map['login_status'],
          sTimestamp: map['s_mobile_time'],
          date: map['date'],
          sLatitude: map['s_latitude'],
          sLongitude: map['s_longitude'],
          sBattery: map['s_battery'],
          eTimestamp: map['e_timestamp'],
          eBattery: map['e_battery'],
          deleteStatus: map['delete_status'],
          createdOn: map['createdOn'],
          createdBy: map['createdBy'],
          updatedOn: map['updatedOn'],
          updatedBy: map['updatedBy'],
          locId: map['loc_id'],
          orgId: map['org_id'],
          cmpyId: map['cmpy_id'],
        );

  AttendanceStatusModel copyWith({
    int? employeeLogId,
    int? employeeId,
    int? loginStatus,
    String? sTimestamp,
    String? date,
    String? sLatitude,
    String? sLongitude,
    int? sBattery,
    String? eTimestamp,
    int? eBattery,
    int? deleteStatus,
    String? createdOn,
    int? createdBy,
    String? updatedOn,
    int? updatedBy,
    int? locId,
    int? orgId,
    int? cmpyId,
  }) {
    return AttendanceStatusModel(
      employeeLogId: employeeLogId ?? this.employeeLogId,
      employeeId: employeeId ?? this.employeeId,
      loginStatus: loginStatus ?? this.loginStatus,
      sTimestamp: sTimestamp ?? this.sTimestamp,
      date: date ?? this.date,
      sLatitude: sLatitude ?? this.sLatitude,
      sLongitude: sLongitude ?? this.sLongitude,
      sBattery: sBattery ?? this.sBattery,
      eTimestamp: eTimestamp ?? this.eTimestamp,
      eBattery: eBattery ?? this.eBattery,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      createdOn: createdOn ?? this.createdOn,
      createdBy: createdBy ?? this.createdBy,
      updatedOn: updatedOn ?? this.updatedOn,
      updatedBy: updatedBy ?? this.updatedBy,
      locId: locId ?? this.locId,
      orgId: orgId ?? this.orgId,
      cmpyId: cmpyId ?? this.cmpyId,
    );
  }

  DataMap toMap() => {
        'employee_log_id': employeeLogId,
        'employee_id': employeeId,
        'login_status': loginStatus,
        's_mobile_time': sTimestamp,
        'date': date,
        's_latitude': sLatitude,
        's_longitude': sLongitude,
        's_battery': sBattery,
        'e_timestamp': eTimestamp,
        'e_battery': eBattery,
        'delete_status': deleteStatus,
        'createdOn': createdOn,
        'createdBy': createdBy,
        'updatedOn': updatedOn,
        'updatedBy': updatedBy,
        'loc_id': locId,
        'org_id': orgId,
        'cmpy_id': cmpyId,
      };

  String toJson() => jsonEncode(toMap());
}
