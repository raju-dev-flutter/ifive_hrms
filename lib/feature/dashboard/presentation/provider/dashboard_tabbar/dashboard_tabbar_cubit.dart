import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ifive_hrms/core/core.dart';

part 'dashboard_tabbar_state.dart';

class DashboardTabBarCubit extends Cubit<DashboardTabBarState> {
  DashboardTabBarCubit()
      : super(const DashboardTabBarState(DashboardTabItem.leave, 0));

  void getTabBarItem(DashboardTabItem navbarItem) {
    switch (navbarItem) {
      case DashboardTabItem.leave:
        emit(const DashboardTabBarState(DashboardTabItem.leave, 0));
        break;
      case DashboardTabItem.misspunch:
        emit(const DashboardTabBarState(DashboardTabItem.misspunch, 1));
        break;
      case DashboardTabItem.permission:
        emit(const DashboardTabBarState(DashboardTabItem.permission, 2));
        break;
    }
  }
}
