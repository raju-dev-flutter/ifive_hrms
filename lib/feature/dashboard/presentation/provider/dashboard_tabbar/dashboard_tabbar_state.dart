part of 'dashboard_tabbar_cubit.dart';

class DashboardTabBarState extends Equatable {
  final DashboardTabItem dashboardTab;
  final int index;

  const DashboardTabBarState(this.dashboardTab, this.index);

  @override
  List<Object> get props => [dashboardTab, index];
}
