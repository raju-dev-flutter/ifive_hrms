import '../../../../core/core.dart';
import '../../leave.dart';

class LeaveType extends UseCaseWithoutParams<LeaveTypeModel> {
  const LeaveType(this._repository);

  final LeaveRepository _repository;

  @override
  ResultFuture<LeaveTypeModel> call() async {
    return _repository.leaveType();
  }
}
