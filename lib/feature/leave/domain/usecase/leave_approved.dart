import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../leave.dart';

class LeaveApprovedUseCase
    extends UseCaseWithParams<LeaveApprovedModel, LeaveApprovedRequestParams> {
  const LeaveApprovedUseCase(this._repository);

  final LeaveRepository _repository;

  @override
  ResultFuture<LeaveApprovedModel> call(
      LeaveApprovedRequestParams params) async {
    return _repository.leaveApproved(params.fromDate, params.toDate);
  }
}

class LeaveApprovedRequestParams extends Equatable {
  final String fromDate;
  final String toDate;

  const LeaveApprovedRequestParams(
      {required this.fromDate, required this.toDate});

  @override
  List<Object?> get props => [fromDate, toDate];
}
