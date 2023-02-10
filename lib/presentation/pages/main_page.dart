import 'package:auto_route/auto_route.dart';
import 'package:ditonton/presentation/route/app_router.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  static const routeName = '/main-page';

   MainPage({Key? key}) : super(key: key);
  final _innerRouterKey = GlobalKey<AutoTabsRouterPageViewState>();

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter.pageView(
      key: _innerRouterKey,
      physics: NeverScrollableScrollPhysics(),
      routes: const [
        HomeMovieRoute(),
        HomeTvRoute(),
        MainWatchListRoute(),
        AboutRoute()
      ],
      builder: (context, child, _) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
            body: child,
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: tabsRouter.activeIndex,
              selectedItemColor: Colors.purple,
              onTap: (index) {
                tabsRouter.setActiveIndex(index);
              },
              items: [
                BottomNavigationBarItem(
                    label: 'Movie',
                    icon: Icon(
                      Icons.movie,
                    )),
                BottomNavigationBarItem(label: 'Tv', icon: Icon(Icons.tv)),
                BottomNavigationBarItem(
                    label: 'Watchlist', icon: Icon(Icons.favorite)),
                BottomNavigationBarItem(
                    label: 'About', icon: Icon(Icons.info)),
              ],
            ));
      },
    );
  }
}
