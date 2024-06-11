import 'dart:convert';

import '../../../../core/core.dart';
import '../../attendance.dart';

class AttendanceUserModel extends AttendanceUser {
  const AttendanceUserModel({
    required super.employeeId,
    required super.firstName,
    required super.id,
    required super.active,
    required super.type,
    required super.sTime,
    required super.taskDescription,
    required super.sTimestamp,
    required super.eTimestamp,
    required super.timeTaken,
  });

  factory AttendanceUserModel.fromJson(String source) =>
      AttendanceUserModel.fromMap(jsonDecode(source) as DataMap);

  AttendanceUserModel.fromMap(DataMap map)
      : this(
          employeeId: map['employee_id'],
          firstName: map['first_name'],
          id: map['id'],
          active: map['active'],
          type: map['type'],
          sTime: map['s_time'],
          taskDescription: map['task_desc'],
          sTimestamp: map['s_timestamp'],
          eTimestamp: map['e_timestamp'],
          timeTaken: map['timetaken'],
        );

  AttendanceUserModel copyWith({
    int? employeeId,
    String? firstName,
    int? id,
    String? active,
    int? type,
    String? sTime,
    String? taskDescription,
    String? sTimestamp,
    String? eTimestamp,
    String? timeTaken,
  }) {
    return AttendanceUserModel(
      employeeId: employeeId ?? this.employeeId,
      firstName: firstName ?? this.firstName,
      id: id ?? this.id,
      active: active ?? this.active,
      type: type ?? this.type,
      sTime: sTime ?? this.sTime,
      taskDescription: taskDescription ?? this.taskDescription,
      sTimestamp: sTimestamp ?? this.sTimestamp,
      eTimestamp: eTimestamp ?? this.eTimestamp,
      timeTaken: timeTaken ?? this.timeTaken,
    );
  }

  DataMap toMap() => {
        'employee_id': employeeId,
        'first_name': firstName,
        'active': active,
        'type': type,
        's_time': sTime,
        'task_desc': taskDescription,
        's_timestamp': sTimestamp,
        'e_timestamp': eTimestamp,
        'timetaken': timeTaken
      };

  String toJson() => jsonEncode(toMap());
}
