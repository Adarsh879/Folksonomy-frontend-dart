import 'package:flutter/material.dart';
import 'package:folksonomy_frontend/ui/screens/key_list.dart';
import 'package:folksonomy_frontend/ui/screens/search.dart';
import 'enums.dart';

class TabNavigatorRoutes {
  static const String keys = '/keys';
  static const String search = '/search';
}

class TabNavigator extends StatelessWidget {
  TabNavigator({required this.navigatorKey, required this.tabItem});
  final GlobalKey<NavigatorState> navigatorKey;
  final TabItem tabItem;

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context) {
    return {
      TabNavigatorRoutes.keys: (context) => ListPage(),
      TabNavigatorRoutes.search: (context) => SearchKey(),
    };
  }

  final Map<TabItem, String> _initialRoute = {
    TabItem.keys: TabNavigatorRoutes.keys,
    TabItem.search: TabNavigatorRoutes.search,
  };

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilders(context);
    return Navigator(
      key: navigatorKey,
      initialRoute: _initialRoute[tabItem],
      onGenerateRoute: (routeSettings) {
        if (routeSettings.name == '/') return null;
        return MaterialPageRoute(
          builder: (context) => routeBuilders[routeSettings.name!]!(context),
        );
      },
    );
  }
}
