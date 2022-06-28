import 'package:ditonton/data/models/screen_model.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/main_watch_list.dart';
import 'package:ditonton/presentation/pages/movie/home_movie_page.dart';
import 'package:ditonton/presentation/pages/tv/home_tv_page.dart';
import 'package:ditonton/presentation/widgets/exit_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const FIRST_SCREEN = 0;
const SECOND_SCREEN = 1;
const THIRD_SCREEN = 2;
const FORTH_SCREEN = 3;

class NavigationProvider extends ChangeNotifier {
  /// Shortcut method for getting [NavigationProvider].
  static NavigationProvider of(BuildContext context) =>
      Provider.of<NavigationProvider>(context, listen: false);

  int _currentScreenIndex = FIRST_SCREEN;
  int _dataScreen = 0;
  List<int> _listTabActive = [];

  int get currentTabIndex => _currentScreenIndex;

  int get currentDataScreen => _dataScreen;

  List<int> get listTabActive => _listTabActive;

  final Map<int, Screen> _screens = {
    FIRST_SCREEN: Screen(
      title: 'Movie',
      icon: Icon(Icons.movie),
      iconActive: Icon(
        Icons.movie,
        color: Colors.purple,
      ),
      child: HomeMoviePage(),
      initialRoute: HomeMoviePage.ROUTE_NAME,
      navigatorState: GlobalKey<NavigatorState>(),
      onGenerateRoute: (settings) {
        print('Generating route: ${settings.name}');
        switch (settings.name) {
          // case PushedScreen.route:
          //   return MaterialPageRoute(builder: (_) => PushedScreen());
          default:
            return MaterialPageRoute(builder: (_) => HomeMoviePage());
        }
      },
      scrollController: ScrollController(),
    ),
    SECOND_SCREEN: Screen(
      title: 'Tv',
      icon: Icon(Icons.tv),
      iconActive: Icon(
        Icons.tv,
        color: Colors.purple,
      ),
      child: HomeTvPage(),
      initialRoute: HomeTvPage.ROUTE_NAME,
      navigatorState: GlobalKey<NavigatorState>(),
      onGenerateRoute: (settings) {
        print('Generating route: ${settings.name}');
        switch (settings.name) {
          default:
            return MaterialPageRoute(builder: (_) => HomeTvPage());
        }
      },
      scrollController: ScrollController(),
    ),
    THIRD_SCREEN: Screen(
      title: 'Watchlist',
      icon: Icon(Icons.favorite),
      iconActive: Icon(
        Icons.favorite,
        color: Colors.purple,
      ),
      child: MainWatchList(),
      initialRoute: MainWatchList.routeName,
      navigatorState: GlobalKey<NavigatorState>(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          default:
            return MaterialPageRoute(builder: (_) => MainWatchList());
        }
      },
      scrollController: ScrollController(),
    ),
    FORTH_SCREEN: Screen(
      title: 'About',
      icon: Icon(Icons.info),
      iconActive: Icon(
        Icons.info,
        color: Colors.purple,
      ),
      child: AboutPage(),
      initialRoute: AboutPage.ROUTE_NAME,
      navigatorState: GlobalKey<NavigatorState>(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          default:
            return MaterialPageRoute(builder: (_) => AboutPage());
        }
      },
      scrollController: ScrollController(),
    ),
  };

  List<Screen> get screens => _screens.values.toList();

  Screen? get currentScreen => _screens[_currentScreenIndex];

  void setDataScreen(int data) {
    _dataScreen = data;
    notifyListeners();
  }

  /// Set currently visible tab.
  void setTab(int tab) {
    if (tab == currentTabIndex) {
      _scrollToStart();
    } else {
      _currentScreenIndex = tab;
      notifyListeners();
    }
    if (!_listTabActive.contains(tab)) {
      _listTabActive.add(tab);
      notifyListeners();
    }
  }

  /// If currently displayed screen has given [ScrollController] animate it
  /// to the start of scroll view.
  void _scrollToStart() {
    if (currentScreen?.scrollController != null &&
        currentScreen!.scrollController!.hasClients) {
      currentScreen!.scrollController!.animateTo(
        0,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }

  /// Provide this to [WillPopScope] callback.
  Future<bool> onWillPop(BuildContext context) async {
    final currentNavigatorState = currentScreen?.navigatorState.currentState;

    if (currentNavigatorState!.canPop()) {
      currentNavigatorState.pop();
      return false;
    } else {
      if (currentTabIndex != FIRST_SCREEN) {
        setTab(FIRST_SCREEN);
        notifyListeners();
        return false;
      } else {
        return await showDialog(
          context: context,
          builder: (context) => ExitAlertDialog(),
        );
      }
    }
  }
}
