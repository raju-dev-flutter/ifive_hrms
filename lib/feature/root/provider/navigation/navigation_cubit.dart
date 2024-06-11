import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState(NavbarItem.dashboard, 0));

  void getNavBarItem(NavbarItem navbarItem) {
    switch (navbarItem) {
      case NavbarItem.dashboard:
        emit(const NavigationState(NavbarItem.dashboard, 0));
        break;

      case NavbarItem.home:
        emit(const NavigationState(NavbarItem.home, 1));
        break;

      case NavbarItem.calendar:
        emit(const NavigationState(NavbarItem.calendar, 2));
        break;

      case NavbarItem.task:
        emit(const NavigationState(NavbarItem.task, 3));
        break;

      case NavbarItem.database:
        emit(const NavigationState(NavbarItem.database, 4));
        break;

      case NavbarItem.account:
        emit(const NavigationState(NavbarItem.account, 5));
        break;
    }
  }
}
