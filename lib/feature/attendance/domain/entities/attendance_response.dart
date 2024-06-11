import 'package:equatable/equatable.dart';

import '../../attendance.dart';

class AttendanceResponse extends Equatable {
  final AttendanceStatus? workDetails;
  final String? message;
  final String? profileImage;

  const AttendanceResponse({this.workDetails, this.message, this.profileImage});

  const AttendanceResponse.empty()
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

  @override
  List<Object?> get props => [workDetails, message, profileImage];
}
