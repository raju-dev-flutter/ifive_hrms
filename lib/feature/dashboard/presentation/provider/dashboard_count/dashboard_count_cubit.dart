import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../dashboard.dart';

part 'dashboard_count_state.dart';

class DashboardCountCubit extends Cubit<DashboardCountState> {
  DashboardCountCubit({required DashboardCountUseCase $DashboardCountUseCase})
      : _$DashboardCountUseCase = $DashboardCountUseCase,
        super(const DashboardCountInitial());

  final DashboardCountUseCase _$DashboardCountUseCase;

  void dashboardCount() async {
    emit(const DashboardCountLoading());
    final response = await _$DashboardCountUseCase();
    response.fold(
      (__) => emit(DashboardCountFailed(message: __.message)),
      (_) => emit(DashboardCountLoaded(dashboardCount: _)),
    );
  }
}
