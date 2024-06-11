import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../feature.dart';
import '../../../domain/domain.dart';

part 'misspunch_history_state.dart';

class MisspunchHistoryCubit extends Cubit<MisspunchHistoryState> {
  MisspunchHistoryCubit({required GetMisspunchHistory getMisspunchHistory})
      : _getMisspunchHistory = getMisspunchHistory,
        super(const MisspunchHistoryInitial());

  final GetMisspunchHistory _getMisspunchHistory;

  void getMisspunchHistory(String fromDate, String toDate) async {
    emit(const MisspunchHistoryLoading());

    final misspunchResponse = await _getMisspunchHistory(
        MisspunchHistoryParams(fromDate: fromDate, toDate: toDate));

    misspunchResponse.fold(
      (failure) => emit(MisspunchHistoryFailed(message: failure.message)),
      (misspunchList) => emit(MisspunchHistoryLoaded(misspunch: misspunchList)),
    );
  }
}
