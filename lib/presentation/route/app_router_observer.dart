import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';

class AppRouterObserver extends AutoRouterObserver{
@override
  void didPush(Route route, Route? previousRoute) {
    debugPrint('New route pushed: ${route.settings.name}');
    if (previousRoute != null) {
      debugPrint('previous route: ${previousRoute.settings.name}');
    }
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    debugPrint('back to route: ${route.settings.name}');
    debugPrint('previous route: ${previousRoute!.settings.name}');
  }

  // only override to observer tab routes
  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    debugPrint('Tab route visited: ${route.name}');
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    debugPrint('Tab route re-visited: ${route.name}');
  }
  
}