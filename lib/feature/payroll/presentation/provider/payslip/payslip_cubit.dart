import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../feature.dart';

part 'payslip_state.dart';

class PaySlipCubit extends Cubit<PaySlipState> {
  PaySlipCubit({required PaySlipUseCase $PaySlipUseCase})
      : _$PaySlipUseCase = $PaySlipUseCase,
        super(const PaySlipInitial());

  final PaySlipUseCase _$PaySlipUseCase;

  void payslip(String from, String to) async {
    emit(const PaySlipLoading());
    final paySlipResponse = await _$PaySlipUseCase(
        PaySlipRequestParams(fromDate: from, toDate: to));
    paySlipResponse.fold(
      (_) => emit(PaySlipFailure(_.message)),
      (__) => emit(PaySlipLoaded(__)),
    );
  }
}
