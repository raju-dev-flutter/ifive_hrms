import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../../feature.dart';

class PaySlipDocumentUseCase
    extends UseCaseWithParams<PaySlipModel, PaySlipParams> {
  const PaySlipDocumentUseCase(this._repository);

  final PayrollRepository _repository;

  @override
  ResultFuture<PaySlipModel> call(PaySlipParams params) {
    return _repository.payslipDocument(params.id);
  }
}

class PaySlipParams extends Equatable {
  final String id;
  const PaySlipParams(this.id);

  @override
  List<Object?> get props => [id];
}
