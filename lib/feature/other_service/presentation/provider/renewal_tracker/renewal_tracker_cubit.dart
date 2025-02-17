import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../feature.dart';

part 'renewal_tracker_state.dart';

class RenewalTrackerCubit extends Cubit<RenewalTrackerState> {
  RenewalTrackerCubit({required RenewalTrackerUseCase $RenewalTrackerUseCase})
      : _$RenewalTrackerUseCase = $RenewalTrackerUseCase,
        super(const RenewalTrackerInitial());

  final RenewalTrackerUseCase _$RenewalTrackerUseCase;

  void renewalTracking({required String status}) async {
    emit(const RenewalTrackerLoading());
    final response = await _$RenewalTrackerUseCase(status);
    response.fold(
      (_) => emit(RenewalTrackerFailure(_.message)),
      (__) => emit(RenewalTrackerLoaded(__)),
    );
  }
}
