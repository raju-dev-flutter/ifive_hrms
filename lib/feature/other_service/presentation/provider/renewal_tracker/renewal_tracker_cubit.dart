import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../feature.dart';

part 'renewal_tracker_state.dart';

class RenewalTrackerCubit extends Cubit<RenewalTrackerState> {
  RenewalTrackerCubit({required RenewalTrackerUseCase $RenewalTrackerUseCase})
      : _$RenewalTrackerUseCase = $RenewalTrackerUseCase,
        super(const RenewalTrackerInitial());

  final RenewalTrackerUseCase _$RenewalTrackerUseCase;

  void renewalTracking() async {
    emit(const RenewalTrackerLoading());
    final response = await _$RenewalTrackerUseCase();
    response.fold(
      (_) => emit(RenewalTrackerFailure(_.message)),
      (__) => emit(RenewalTrackerLoaded(__)),
    );
  }
}
