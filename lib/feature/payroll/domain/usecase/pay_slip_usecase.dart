import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../../feature.dart';

class PaySlipUseCase
    extends UseCaseWithParams<PaySlipResponseModel, PaySlipRequestParams> {
  const PaySlipUseCase(this._repository);

  final PayrollRepository _repository;

  @override
  ResultFuture<PaySlipResponseModel> call(PaySlipRequestParams params) {
    return _repository.payslip(params.fromDate, params.toDate);
  }
}

class PaySlipRequestParams extends Equatable {
  final String fromDate;
  final String toDate;

  const PaySlipRequestParams({required this.fromDate, required this.toDate});

  @override
  List<Object?> get props => [fromDate, toDate];
}
