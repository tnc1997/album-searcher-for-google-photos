import 'package:flutter/material.dart';

import '../pages/home_page.dart';
import '../pages/settings_page.dart';
import '../route_paths/route_path.dart';
import '../states/router_state.dart';

class MainRouterDelegate extends RouterDelegate<RoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<RoutePath> {
  @override
  final navigatorKey = GlobalKey<NavigatorState>();

  RouterStateData _routerStateData;

  MainRouterDelegate({
    required RouterStateData routerStateData,
  }) : _routerStateData = routerStateData;

  RouterStateData get routerStateData => _routerStateData;

  set routerStateData(RouterStateData routerStateData) {
    if (routerStateData != _routerStateData) {
      _routerStateData = routerStateData;
      notifyListeners();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        if (routerStateData.selectedIndex == 0)
          MaterialPage<void>(
            child: HomePage(),
            key: ValueKey('home_page'),
          )
        else if (routerStateData.selectedIndex == 1)
          MaterialPage<void>(
            child: SettingsPage(),
            key: ValueKey('settings_page'),
          ),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(RoutePath path) async {}
}
