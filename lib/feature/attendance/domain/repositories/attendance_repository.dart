import '../../../../core/core.dart';
import '../../attendance.dart';

abstract class AttendanceRepository {
  ResultFuture<GeoLocationResponse> updateWorkStartLocation(DataMap body);

  ResultFuture<GeoLocationResponse> updateWorkEndLocation(
    int battery,
    String mobileTime,
    String timestamp,
    String taskDescription,
    int type,
    double latitude,
    double longitude,
    String geoAddress,
  );

  ResultFuture<OverAllAttendanceModel> getAttendanceUserList(
      String date, String id);

  ResultFuture<AttendanceReportModel> getAttendanceReportList(
      String fromDate, String toDate);

  ResultFuture<GPRSResponseModel> gprsChecker();
}
