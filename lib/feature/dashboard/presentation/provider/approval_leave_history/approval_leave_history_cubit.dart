import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../dashboard.dart';

part 'approval_leave_history_state.dart';

class ApprovalLeaveHistoryCubit extends Cubit<ApprovalLeaveHistoryState> {
  ApprovalLeaveHistoryCubit(
      {required ApprovalLeaveHistoryUseCase $ApprovalLeaveHistoryUseCase})
      : _$ApprovalLeaveHistoryUseCase = $ApprovalLeaveHistoryUseCase,
        super(const ApprovalLeaveHistoryInitial());

  final ApprovalLeaveHistoryUseCase _$ApprovalLeaveHistoryUseCase;

  void approvalLeaveHistory(String date) async {
    emit(const ApprovalLeaveHistoryLoading());
    final response = await _$ApprovalLeaveHistoryUseCase(date);
    response.fold(
      (_) => emit(ApprovalLeaveHistoryFailed(message: _.message)),
      (_) => emit(ApprovalLeaveHistoryLoaded(approvalLeaveHistory: _)),
    );
  }
}
