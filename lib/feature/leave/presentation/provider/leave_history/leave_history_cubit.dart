import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../leave.dart';

part 'leave_history_state.dart';

class LeaveHistoryCubit extends Cubit<LeaveHistoryState> {
  LeaveHistoryCubit({required LeaveHistory leaveHistory})
      : _leaveHistory = leaveHistory,
        super(initialState());

  final LeaveHistory _leaveHistory;

  static initialState() => const LeaveHistoryInitial();

  void getLeaveHistory() async {
    emit(const LeaveHistoryLoading());

    final misspunchResponse = await _leaveHistory.call();

    misspunchResponse.fold(
      (_) => emit(LeaveHistoryFailed(message: _.message)),
      (__) => emit(LeaveHistoryLoaded(history: __)),
    );
  }
}
