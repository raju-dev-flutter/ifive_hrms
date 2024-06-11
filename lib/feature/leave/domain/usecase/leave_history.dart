import '../../../../core/core.dart';
import '../../leave.dart';

class LeaveHistory extends UseCaseWithoutParams<LeaveHistoryModel> {
  const LeaveHistory(this._repository);

  final LeaveRepository _repository;

  @override
  ResultFuture<LeaveHistoryModel> call() async {
    return _repository.leaveHistory();
  }
}
