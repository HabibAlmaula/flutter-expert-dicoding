import 'package:ditonton/presentation/provider/navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  static const routeName = '/main-page';

  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final PageController _pageController = PageController();

    return Consumer<NavigationProvider>(
      builder: (context, provider, child) {
        // Create bottom navigation bar items from screens.
        final bottomNavigationBarItems = provider.screens
            .map((screen) => BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: (provider.screens.indexOf(screen) ==
                          provider.currentTabIndex)
                      ? screen.iconActive
                      : screen.icon,
                ),
                label: screen.title,
                backgroundColor: Colors.transparent,
                tooltip: ''))
            .toList();

        // Initialize [Navigator] instance for each screen.
        final screens = provider.screens
            .map(
              (screen) => Navigator(
                key: screen.navigatorState,
                onGenerateRoute: screen.onGenerateRoute,
              ),
            )
            .toList();

        return WillPopScope(
          onWillPop: () async => provider.onWillPop(context),
          child: Scaffold(
            body:
                // PageView(
                //   controller: _pageController,
                //   children: screens,
                //   physics: const NeverScrollableScrollPhysics(),
                // ),
                IndexedStack(
              children: screens,
              index: provider.currentTabIndex,
            ),
            bottomNavigationBar: BottomNavigationBar(
              fixedColor: Colors.black87,
              elevation: 10,
              type: BottomNavigationBarType.fixed,
              items: bottomNavigationBarItems,
              // selectedLabelStyle: poppinsLight.copyWith(
              //     fontSize: 13.0,
              //     fontWeight: FontWeight.bold,
              //     color: pinBlack_60),
              // unselectedLabelStyle: poppinsLight.copyWith(fontSize: 12.0),
              currentIndex: provider.currentTabIndex,
              onTap: (page) {
                provider.setTab(page);
                // _pageController.animateToPage(page,
                //     duration: const Duration(milliseconds: 300),
                //     curve: Curves.easeIn);
              },
            ),
          ),
        );
      },
    );
  }
}
