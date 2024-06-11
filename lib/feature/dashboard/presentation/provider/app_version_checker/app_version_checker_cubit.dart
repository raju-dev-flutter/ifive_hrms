import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../dashboard.dart';

part 'app_version_checker_state.dart';

class AppVersionCheckerCubit extends Cubit<AppVersionCheckerState> {
  AppVersionCheckerCubit({required AppVersionUseCase $AppVersionUseCase})
      : _$AppVersionUseCase = $AppVersionUseCase,
        super(const AppVersionCheckerInitial());

  final AppVersionUseCase _$AppVersionUseCase;

  void appVersion() async {
    emit(const AppVersionCheckerLoading());
    final response = await _$AppVersionUseCase();
    response.fold(
      (_) => emit(AppVersionCheckerFailed(message: _.message)),
      (__) => emit(AppVersionCheckerLoaded(appVersion: __)),
    );
  }
}
