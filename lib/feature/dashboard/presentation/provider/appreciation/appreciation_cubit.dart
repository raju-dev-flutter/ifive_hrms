import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../dashboard.dart';

part 'appreciation_state.dart';

class AppreciationCubit extends Cubit<AppreciationState> {
  AppreciationCubit({required AppreciationUseCase appreciationUseCase})
      : _appreciationUseCase = appreciationUseCase,
        super(const AppreciationInitial());

  final AppreciationUseCase _appreciationUseCase;

  void getAppreciation() async {
    emit(const AppreciationLoading());
    final response = await _appreciationUseCase();
    response.fold(
      (failure) => emit(AppreciationFailed(message: failure.message)),
      (appreciation) => emit(AppreciationLoaded(appreciation: appreciation)),
    );
  }
}
