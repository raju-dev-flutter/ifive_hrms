import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../attendance.dart';

class UpdateWorkEndLocation
    extends UseCaseWithParams<GeoLocationResponse, AttendanceEndRequestParams> {
  const UpdateWorkEndLocation(this._repository);

  final AttendanceRepository _repository;

  @override
  ResultFuture<GeoLocationResponse> call(
      AttendanceEndRequestParams params) async {
    return _repository.updateWorkEndLocation(
        params.battery,
        params.mobileTime,
        params.timestamp,
        params.taskDescription,
        params.type,
        params.latitude,
        params.longitude,
        params.geoAddress);
  }
}

class AttendanceEndRequestParams extends Equatable {
  final int battery;
  final String mobileTime;
  final String timestamp;
  final String taskDescription;
  final int type;
  final double latitude;
  final double longitude;
  final String geoAddress;

  const AttendanceEndRequestParams({
    required this.battery,
    required this.mobileTime,
    required this.timestamp,
    required this.taskDescription,
    required this.type,
    required this.latitude,
    required this.longitude,
    required this.geoAddress,
  });

  @override
  List<Object?> get props =>
      [battery, mobileTime, timestamp, taskDescription, type];
}
