import 'package:equatable/equatable.dart';

class AttendanceStatus extends Equatable {
  final int? employeeLogId;
  final int? employeeId;
  final int? loginStatus;
  final String? sTimestamp;
  final String? date;
  final String? sLatitude;
  final String? sLongitude;
  final int? sBattery;
  final String? eTimestamp;
  final int? eBattery;
  final int? deleteStatus;
  final String? createdOn;
  final int? createdBy;
  final String? updatedOn;
  final int? updatedBy;
  final int? locId;
  final int? orgId;
  final int? cmpyId;

  const AttendanceStatus({
    this.employeeLogId,
    this.employeeId,
    this.loginStatus,
    this.sTimestamp,
    this.date,
    this.sLatitude,
    this.sLongitude,
    this.sBattery,
    this.eTimestamp,
    this.eBattery,
    this.deleteStatus,
    this.createdOn,
    this.createdBy,
    this.updatedOn,
    this.updatedBy,
    this.locId,
    this.orgId,
    this.cmpyId,
  });

  const AttendanceStatus.empty()
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

  @override
  List<Object?> get props => [
        employeeLogId,
        employeeId,
        loginStatus,
        sTimestamp,
        date,
        sLatitude,
        sLongitude,
        sBattery,
        eTimestamp,
        eBattery,
        deleteStatus,
        createdOn,
        createdBy,
        updatedOn,
        updatedBy,
        locId,
        orgId,
        cmpyId,
      ];
}
