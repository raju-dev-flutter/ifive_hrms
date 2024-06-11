import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../feature.dart';

part 'misspunch_approved_state.dart';

class MisspunchApprovedCubit extends Cubit<MisspunchApprovedState> {
  MisspunchApprovedCubit(
      {required MisspunchApprovedUseCase misspunchApprovedUseCase})
      : _misspunchApprovedUseCase = misspunchApprovedUseCase,
        super(const MisspunchApprovedInitial());

  final MisspunchApprovedUseCase _misspunchApprovedUseCase;

  void misspunchApproved(String fromDate, String toDate) async {
    emit(const MisspunchApprovedLoading());

    final misspunchResponse = await _misspunchApprovedUseCase(
        MisspunchApprovedParams(fromDate: fromDate, toDate: toDate));

    misspunchResponse.fold(
      (failure) => emit(MisspunchApprovedFailed(message: failure.message)),
      (misspunchList) =>
          emit(MisspunchApprovedLoaded(misspunch: misspunchList)),
    );
  }
}
