import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../attendance.dart';

class UpdateWorkStartLocation extends UseCaseWithParams<GeoLocationResponse,
    AttendanceStartRequestParams> {
  const UpdateWorkStartLocation(this._repository);

  final AttendanceRepository _repository;

  @override
  ResultFuture<GeoLocationResponse> call(
      AttendanceStartRequestParams params) async {
    return _repository.updateWorkStartLocation(
      params.body,
      // params.mobileTime,
      // params.timestamp,
      // params.latitude,
      // params.longitude,
      // params.geoAddress
    );
  }
}

class AttendanceStartRequestParams extends Equatable {
  final DataMap body;
  // final int battery;
  // final String mobileTime;
  // final String timestamp;
  // final double latitude;
  // final double longitude;
  // final String geoAddress;

  const AttendanceStartRequestParams({required this.body
      // battery,
      // required this.mobileTime,
      // required this.timestamp,
      // required this.latitude,
      // required this.longitude,
      // required this.geoAddress,
      });

  @override
  List<Object?> get props => [body];
}
