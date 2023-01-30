import 'package:bloc/bloc.dart';
import 'package:ditonton/common/app_enum.dart';
import 'package:equatable/equatable.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationState(NavbarItem.Movie, 0));

  void onchangeNavbar(int index) {
    switch (index) {
      case 0:
        emit(NavigationState(NavbarItem.Movie, 0));
        break;
      case 1:
        emit(NavigationState(NavbarItem.Tv, 1));
        break;
      case 2:
        emit(NavigationState(NavbarItem.Watchlist, 2));
        break;
      case 3:
        emit(NavigationState(NavbarItem.About, 3));
        break;
    }
  }
}
