part of 'dashboard_count_cubit.dart';

abstract class DashboardCountState extends Equatable {
  const DashboardCountState();

  @override
  List<Object> get props => [];
}

class DashboardCountInitial extends DashboardCountState {
  const DashboardCountInitial();
}

class DashboardCountLoading extends DashboardCountState {
  const DashboardCountLoading();
}

class DashboardCountLoaded extends DashboardCountState {
  final DashboardCountModel dashboardCount;

  const DashboardCountLoaded({required this.dashboardCount});

  @override
  List<Object> get props => [DashboardCount];
}

class DashboardCountFailed extends DashboardCountState {
  final String message;

  const DashboardCountFailed({required this.message});

  @override
  List<Object> get props => [];
}
