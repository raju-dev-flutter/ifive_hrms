import 'dart:convert';

import '../../../../core/core.dart';
import '../../../attendance/attendance.dart';
import '../../dashboard.dart';

class AttendanceResponseModel extends AttendanceResponse {
  const AttendanceResponseModel(
      {required super.workDetails,
      required super.message,
      required super.profileImage});

  const AttendanceResponseModel.empty()
      : this(
          workDetails: const AttendanceStatus(
            employeeLogId: 0,
            employeeId: 0,
            loginStatus: 0,
            sTimestamp: '_empty.sTimestamp',
            date: '_empty.date',
            sLatitude: '0.0',
            sLongitude: '0.0',
            sBattery: 0,
            eTimestamp: '_empty.eTimestamp',
            eBattery: 0,
            deleteStatus: 0,
            createdOn: '_empty.createdOn',
            createdBy: 0,
            updatedOn: '_empty.updatedOn',
            updatedBy: 0,
            locId: 0,
            orgId: 0,
            cmpyId: 0,
          ),
          message: '_empty.message',
          profileImage: '_empty.profileImage',
        );

  factory AttendanceResponseModel.fromJson(String source) =>
      AttendanceResponseModel.fromMap(jsonDecode(source) as DataMap);

  AttendanceResponseModel.fromMap(DataMap map)
      : this(
          workDetails: map['work_details'] != null
              ? AttendanceStatusModel.fromMap(map['work_details'])
              : null,
          message: map['message'],
          profileImage: map['profileimage'],
        );

  AttendanceResponseModel copyWith({
    AttendanceStatus? workDetails,
    String? message,
    String? profileImage,
  }) {
    return AttendanceResponseModel(
      workDetails: workDetails ?? this.workDetails,
      message: message ?? this.message,
      profileImage: profileImage ?? this.profileImage,
    );
  }

  DataMap toMap() => {
        'work_details': workDetails,
        'message': message,
        'profileimage': profileImage,
      };

  String toJson() => jsonEncode(toMap());
}
