import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/core.dart';
import '../../../leave.dart';

part 'leave_crud_event.dart';
part 'leave_crud_state.dart';

class LeaveCrudBloc extends Bloc<LeaveCrudEvent, LeaveCrudState> {
  LeaveCrudBloc(
      {required LeaveRequest leaveRequest,
      required LeaveCancel leaveCancel,
      required LeaveUpdate leaveUpdate})
      : _leaveRequest = leaveRequest,
        _leaveCancel = leaveCancel,
        _leaveUpdate = leaveUpdate,
        super(initialState()) {
    on<CreateLeaveRequestEvent>(_createLeaveRequestEvent);
    on<LeaveCancelEvent>(_leaveCancelEvent);
    on<LeaveUpdateEvent>(_leaveUpdateEvent);
  }

  static initialState() => const LeaveCrudInitial();

  final LeaveRequest _leaveRequest;
  final LeaveCancel _leaveCancel;
  final LeaveUpdate _leaveUpdate;

  void _createLeaveRequestEvent(
      CreateLeaveRequestEvent event, Emitter<LeaveCrudState> emit) async {
    emit(const LeaveCrudLoading());
    final response = await _leaveRequest(LeaveRequestParams(body: event.body));
    response.fold(
      (_) => emit(LeaveCrudFailed(message: _.message)),
      (__) => emit(const LeaveCrudSuccess()),
    );
  }

  void _leaveCancelEvent(
      LeaveCancelEvent event, Emitter<LeaveCrudState> emit) async {
    emit(const LeaveCrudLoading());
    final response =
        await _leaveCancel(LeaveCancelRequestParams(body: event.body));
    response.fold(
      (_) => emit(LeaveCrudFailed(message: _.message)),
      (__) => emit(const LeaveCrudSuccess()),
    );
  }

  void _leaveUpdateEvent(
      LeaveUpdateEvent event, Emitter<LeaveCrudState> emit) async {
    emit(const LeaveCrudLoading());
    final response =
        await _leaveUpdate(LeaveUpdateRequestParams(body: event.body));
    response.fold(
      (_) => emit(LeaveCrudFailed(message: _.message)),
      (__) => emit(const LeaveCrudSuccess()),
    );
  }
}
