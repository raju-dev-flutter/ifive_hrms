import '../../../../core/core.dart';
import '../../../attendance/attendance.dart';
import '../../dashboard.dart';

abstract class DashboardRepository {
  ResultFuture<AttendanceResponse> getAttendanceStatus(String token);

  ResultFuture<AnnouncementResponseModel> appreciation();

  ResultFuture<DashboardCountModel> dashboardCount();

  ResultFuture<ApprovalLeaveHistoryModel> approvalLeaveHistory(String date);

  ResultFuture<AppVersionModel> appVersion();

  ResultFuture<AppMenuModel> appMenu();
}
