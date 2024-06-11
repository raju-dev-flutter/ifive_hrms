import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../leave.dart';

part 'leave_approved_state.dart';

class LeaveApprovedCubit extends Cubit<LeaveApprovedState> {
  LeaveApprovedCubit({required LeaveApprovedUseCase leaveApprovedUseCase})
      : _leaveApprovedUseCase = leaveApprovedUseCase,
        super(initialState());

  final LeaveApprovedUseCase _leaveApprovedUseCase;

  static initialState() => const LeaveApprovedInitial();

  void getLeaveApproved(String fromDate, toDate) async {
    emit(const LeaveApprovedLoading());

    final response = await _leaveApprovedUseCase(
        LeaveApprovedRequestParams(fromDate: fromDate, toDate: toDate));

    response.fold(
      (_) => emit(LeaveApprovedFailed(message: _.message)),
      (leaveApproved) => emit(LeaveApprovedLoaded(approved: leaveApproved)),
    );
  }
}
