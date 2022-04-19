import 'package:flutter/material.dart';
import 'package:folksonomy_frontend/ui/widgets/nav_bar.dart';
import 'package:folksonomy_frontend/utils/enums.dart';
import 'package:folksonomy_frontend/utils/tab_navigator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _currentTab = TabItem.keys;
  final _navigatorKeys = {
    TabItem.keys: GlobalKey<NavigatorState>(),
    TabItem.search: GlobalKey<NavigatorState>()
  };

  void _selectTab(TabItem tabItem) {
    if (tabItem == _currentTab) {
      // pop to first route
      _navigatorKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);
    } else {
      setState(() => _currentTab = tabItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var currentstate = await _navigatorKeys[_currentTab]!.currentState;
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_currentTab]!.currentState!.maybePop();
        if (isFirstRouteInCurrentTab) {
          if (_currentTab != TabItem.keys) {
            _selectTab(TabItem.keys);
            return false;
          }
        }
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        appBar: AppBar(
            title: Center(
          child: Text('Folksonomy Frontend'),
        )),
        body: Stack(children: <Widget>[
          _buildOffstageNavigator(TabItem.keys),
          _buildOffstageNavigator(TabItem.search),
        ]),
        bottomNavigationBar:
            BottomNavigation(currentTab: _currentTab, onSelectTab: _selectTab),
      ),
    );
  }

  Widget _buildOffstageNavigator(TabItem tabItem) {
    return Offstage(
      offstage: _currentTab != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem]!,
        tabItem: tabItem,
      ),
    );
  }
}
