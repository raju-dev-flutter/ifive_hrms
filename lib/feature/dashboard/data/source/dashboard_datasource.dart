import '../../../attendance/attendance.dart';
import '../../dashboard.dart';

abstract class DashboardDataSource {
  Future<AttendanceResponse> getAttendanceStatus(String token);

  Future<AnnouncementResponseModel> appreciation();

  Future<DashboardCountModel> dashboardCount();

  Future<AppVersionModel> appVersion();

  Future<AppMenuModel> appMenu();

  Future<ApprovalLeaveHistoryModel> approvalLeaveHistory(
      String fromDate, String toDate);

  Future<TaskLeadDataModel> taskLeadData();
}
