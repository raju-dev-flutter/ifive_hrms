import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../feature.dart';

part 'pay_slip_document_state.dart';

class PaySlipDocumentCubit extends Cubit<PaySlipDocumentState> {
  PaySlipDocumentCubit(
      {required PaySlipDocumentUseCase $PaySlipDocumentUseCase})
      : _$PaySlipDocumentUseCase = $PaySlipDocumentUseCase,
        super(const PaySlipDocumentInitial());

  final PaySlipDocumentUseCase _$PaySlipDocumentUseCase;

  void paySlipDocument(String id) async {
    emit(const PaySlipDocumentLoading());
    final response = await _$PaySlipDocumentUseCase(PaySlipParams(id));
    response.fold(
      (_) => emit(PaySlipDocumentFailure(_.message)),
      (__) => emit(PaySlipDocumentLoaded(__)),
    );
  }
}
