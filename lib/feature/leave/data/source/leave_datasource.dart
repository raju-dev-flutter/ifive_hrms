import '../../../../core/core.dart';
import '../../../feature.dart';

abstract class LeaveDataSource {
  Future<LeaveTypeModel> leaveType();

  Future<LeaveModeModel> leaveMode(int type);

  Future<RemainingLeaveModel> leaveRemaining(int type);

  Future<LeaveBalanceModel> leaveBalanceCalculate(DataMap body);

  Future<LeaveForwardModel> leaveForward(int type, int noOfDay);

  Future<LeaveHistoryModel> leaveHistory();

  Future<LeaveApprovedModel> leaveApproved(String fromDate, String toDate);

  Future<void> leaveRequest(DataMap body);

  Future<void> leaveCancel(DataMap body);

  Future<void> leaveUpdate(DataMap body);
}
