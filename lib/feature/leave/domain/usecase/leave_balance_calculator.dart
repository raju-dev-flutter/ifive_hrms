// leave_balance_calculator

import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../../feature.dart';

class LeaveBalanceCalculator
    extends UseCaseWithParams<LeaveBalanceModel, LeaveBalanceCalculatorParams> {
  const LeaveBalanceCalculator(this._repository);

  final LeaveRepository _repository;

  @override
  ResultFuture<LeaveBalanceModel> call(
      LeaveBalanceCalculatorParams params) async {
    return _repository.leaveBalanceCalculate(params.body);
  }
}

class LeaveBalanceCalculatorParams extends Equatable {
  final DataMap body;

  const LeaveBalanceCalculatorParams({required this.body});

  @override
  List<Object?> get props => [body];
}
