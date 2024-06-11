import '../../../../core/core.dart';
import '../../leave.dart';

abstract class LeaveRepository {
  ResultFuture<LeaveTypeModel> leaveType();

  ResultFuture<LeaveModeModel> leaveMode(int type);

  ResultFuture<RemainingLeaveModel> leaveRemaining(int type);

  ResultFuture<LeaveBalanceModel> leaveBalanceCalculate(DataMap body);

  ResultFuture<LeaveForwardModel> leaveForward(int type, int noOfDay);

  ResultFuture<LeaveHistoryModel> leaveHistory();

  ResultFuture<LeaveApprovedModel> leaveApproved(
      String fromDate, String toDate);

  ResultVoid leaveRequest(DataMap body);

  ResultVoid leaveCancel(DataMap body);

  ResultVoid leaveUpdate(DataMap body);
}
