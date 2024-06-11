import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../attendance.dart';

class AttendanceRepositoryImpl implements AttendanceRepository {
  const AttendanceRepositoryImpl(this._datasource);

  final AttendanceDataSource _datasource;

  @override
  ResultFuture<GeoLocationResponse> updateWorkEndLocation(
    int battery,
    String mobileTime,
    String timestamp,
    String taskDescription,
    int type,
    double latitude,
    double longitude,
    String geoAddress,
  ) async {
    try {
      final loginResponse = await _datasource.updateWorkEndLocation(
        battery,
        mobileTime,
        timestamp,
        taskDescription,
        type,
        latitude,
        longitude,
        geoAddress,
      );
      return Right(loginResponse);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<GeoLocationResponse> updateWorkStartLocation(
      DataMap body) async {
    try {
      final loginResponse = await _datasource.updateWorkStartLocation(body);
      return Right(loginResponse);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<OverAllAttendanceModel> getAttendanceUserList(
      String date, String id) async {
    try {
      final attendanceUserListResponse =
          await _datasource.getAttendanceUserList(date, id);
      return Right(attendanceUserListResponse);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<AttendanceReportModel> getAttendanceReportList(
      String fromDate, String toDate) async {
    try {
      final attendanceResponse =
          await _datasource.getAttendanceReportList(fromDate, toDate);
      return Right(attendanceResponse);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<GPRSResponseModel> gprsChecker() async {
    try {
      final response = await _datasource.gprsChecker();
      return Right(response);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }
}
