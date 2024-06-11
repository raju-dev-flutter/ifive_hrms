import 'package:equatable/equatable.dart';
import '../../../../core/core.dart';
import '../../leave.dart';

class RemainingLeave
    extends UseCaseWithParams<RemainingLeaveModel, RemainingLeaveParams> {
  const RemainingLeave(this._repository);

  final LeaveRepository _repository;

  @override
  ResultFuture<RemainingLeaveModel> call(RemainingLeaveParams params) async {
    return _repository.leaveRemaining(params.type);
  }
}

class RemainingLeaveParams extends Equatable {
  final int type;

  const RemainingLeaveParams({required this.type});

  const RemainingLeaveParams.empty() : this(type: 0);

  @override
  List<Object?> get props => [type];
}
