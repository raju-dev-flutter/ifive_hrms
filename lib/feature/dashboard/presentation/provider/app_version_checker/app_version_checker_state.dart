part of 'app_version_checker_cubit.dart';

abstract class AppVersionCheckerState extends Equatable {
  const AppVersionCheckerState();

  @override
  List<Object> get props => [];
}

class AppVersionCheckerInitial extends AppVersionCheckerState {
  const AppVersionCheckerInitial();
}

class AppVersionCheckerLoading extends AppVersionCheckerState {
  const AppVersionCheckerLoading();
}

class AppVersionCheckerLoaded extends AppVersionCheckerState {
  final AppVersionModel appVersion;

  const AppVersionCheckerLoaded({required this.appVersion});

  @override
  List<Object> get props => [appVersion];
}

class AppVersionCheckerFailed extends AppVersionCheckerState {
  final String message;

  const AppVersionCheckerFailed({required this.message});

  @override
  List<Object> get props => [];
}
