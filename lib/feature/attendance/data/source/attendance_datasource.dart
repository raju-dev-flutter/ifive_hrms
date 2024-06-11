import '../../../../core/core.dart';
import '../../attendance.dart';

abstract class AttendanceDataSource {
  Future<GeoLocationResponseModel> updateWorkEndLocation(
    int battery,
    String mobileTime,
    String timestamp,
    String taskDescription,
    int type,
    double latitude,
    double longitude,
    String geoAddress,
  );

  Future<GeoLocationResponseModel> updateWorkStartLocation(DataMap body);

  Future<OverAllAttendanceModel> getAttendanceUserList(String date, String id);

  Future<AttendanceReportModel> getAttendanceReportList(
      String fromDate, String toDate);

  Future<GPRSResponseModel> gprsChecker();
}
