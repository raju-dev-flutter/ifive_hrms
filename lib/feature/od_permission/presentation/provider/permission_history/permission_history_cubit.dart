import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../feature.dart';

part 'permission_history_state.dart';

class PermissionHistoryCubit extends Cubit<PermissionHistoryState> {
  PermissionHistoryCubit({required PermissionHistory permissionHistory})
      : _permissionHistory = permissionHistory,
        super(initialState());

  final PermissionHistory _permissionHistory;

  static initialState() => const PermissionHistoryInitial();

  void getPermissionHistory() async {
    emit(const PermissionHistoryLoading());

    final response = await _permissionHistory.call();

    response.fold(
      (_) => emit(PermissionHistoryFailed(message: _.message)),
      (__) => emit(PermissionHistoryLoaded(history: __)),
    );
  }
}
