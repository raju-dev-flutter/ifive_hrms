part of 'pay_slip_document_cubit.dart';

abstract class PaySlipDocumentState extends Equatable {
  const PaySlipDocumentState();

  @override
  List<Object> get props => [];
}

class PaySlipDocumentInitial extends PaySlipDocumentState {
  const PaySlipDocumentInitial();
}

class PaySlipDocumentLoading extends PaySlipDocumentState {
  const PaySlipDocumentLoading();
}

class PaySlipDocumentLoaded extends PaySlipDocumentState {
  final PaySlipModel payroll;

  const PaySlipDocumentLoaded(this.payroll);

  @override
  List<Object> get props => [payroll];
}

class PaySlipDocumentFailure extends PaySlipDocumentState {
  final String message;

  const PaySlipDocumentFailure(this.message);

  @override
  List<Object> get props => [message];
}
