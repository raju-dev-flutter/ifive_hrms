import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../attendance.dart';

part 'gprs_checker_state.dart';

class GPRSCheckerCubit extends Cubit<GPRSCheckerState> {
  GPRSCheckerCubit({required GPRSCheckerUseCase $GPRSCheckerUseCase})
      : _$GPRSCheckerUseCase = $GPRSCheckerUseCase,
        super(const GPRSCheckerInitial());

  final GPRSCheckerUseCase _$GPRSCheckerUseCase;

  void gprsChecker() async {
    emit(const GPRSCheckerLoading());
    final response = await _$GPRSCheckerUseCase();

    response.fold(
      (_) => emit(GPRSCheckerFailed(message: _.message)),
      (__) => emit(GPRSCheckerLoaded(gprsResponse: __)),
    );
  }
}
