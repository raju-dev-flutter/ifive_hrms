import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../dashboard.dart';

class ApprovalLeaveHistoryUseCase
    extends UseCaseWithParams<ApprovalLeaveHistoryModel, LeaveApprovalParams> {
  const ApprovalLeaveHistoryUseCase(this._repository);

  final DashboardRepository _repository;

  @override
  ResultFuture<ApprovalLeaveHistoryModel> call(
      LeaveApprovalParams params) async {
    return _repository.approvalLeaveHistory(params.fromDate, params.toDate);
  }
}

class LeaveApprovalParams extends Equatable {
  final String fromDate;
  final String toDate;

  const LeaveApprovalParams(this.fromDate, this.toDate);

  @override
  List<Object> get props => [fromDate, toDate];
}
