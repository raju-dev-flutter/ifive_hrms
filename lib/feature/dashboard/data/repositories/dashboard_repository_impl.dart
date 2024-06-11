import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';

import '../../../../core/core.dart';
import '../../../attendance/attendance.dart';
import '../../dashboard.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  const DashboardRepositoryImpl(this._datasource);

  final DashboardDataSource _datasource;

  @override
  ResultFuture<AttendanceResponse> getAttendanceStatus(String token) async {
    try {
      final attendanceResponse = await _datasource.getAttendanceStatus(token);
      return Right(attendanceResponse);
    } on APIException catch (e) {
      Logger().e(e.message);
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<AnnouncementResponseModel> appreciation() async {
    try {
      final response = await _datasource.appreciation();
      return Right(response);
    } on APIException catch (e) {
      Logger().e(e.message);
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<DashboardCountModel> dashboardCount() async {
    try {
      final response = await _datasource.dashboardCount();
      return Right(response);
    } on APIException catch (e) {
      Logger().e(e.message);
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<AppVersionModel> appVersion() async {
    try {
      final response = await _datasource.appVersion();
      return Right(response);
    } on APIException catch (e) {
      Logger().e(e.message);
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<ApprovalLeaveHistoryModel> approvalLeaveHistory(
      String date) async {
    try {
      final response = await _datasource.approvalLeaveHistory(date);
      return Right(response);
    } on APIException catch (e) {
      Logger().e(e.message);
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<AppMenuModel> appMenu() async {
    try {
      final response = await _datasource.appMenu();
      return Right(response);
    } on APIException catch (e) {
      Logger().e(e.message);
      return Left(APIFailure.fromException(e));
    }
  }
}
