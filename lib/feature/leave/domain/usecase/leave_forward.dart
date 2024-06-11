import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../leave.dart';

class LeaveForward
    extends UseCaseWithParams<LeaveForwardModel, LeaveForwardRequestParams> {
  const LeaveForward(this._repository);

  final LeaveRepository _repository;

  @override
  ResultFuture<LeaveForwardModel> call(LeaveForwardRequestParams params) async {
    return _repository.leaveForward(params.type, params.noOfDays);
  }
}

class LeaveForwardRequestParams extends Equatable {
  final int type;
  final int noOfDays;

  const LeaveForwardRequestParams({required this.type, required this.noOfDays});

  const LeaveForwardRequestParams.empty() : this(type: 0, noOfDays: 0);

  @override
  List<Object?> get props => [type, noOfDays];
}
