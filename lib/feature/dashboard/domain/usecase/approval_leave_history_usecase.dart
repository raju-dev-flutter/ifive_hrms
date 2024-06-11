import '../../../../core/core.dart';
import '../../dashboard.dart';

class ApprovalLeaveHistoryUseCase
    extends UseCaseWithParams<ApprovalLeaveHistoryModel, String> {
  const ApprovalLeaveHistoryUseCase(this._repository);

  final DashboardRepository _repository;

  @override
  ResultFuture<ApprovalLeaveHistoryModel> call(String params) async {
    return _repository.approvalLeaveHistory(params);
  }
}
