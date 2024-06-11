part of 'payslip_cubit.dart';

abstract class PaySlipState extends Equatable {
  const PaySlipState();

  @override
  List<Object> get props => [];
}

class PaySlipInitial extends PaySlipState {
  const PaySlipInitial();
}

class PaySlipLoading extends PaySlipState {
  const PaySlipLoading();
}

class PaySlipLoaded extends PaySlipState {
  final PaySlipResponseModel payroll;
  const PaySlipLoaded(this.payroll);

  @override
  List<Object> get props => [payroll];
}

class PaySlipFailure extends PaySlipState {
  final String message;
  const PaySlipFailure(this.message);
  @override
  List<Object> get props => [message];
}
