import 'package:flutter/material.dart';
import 'package:folksonomy_frontend/utils/const/const.dart';
import 'package:folksonomy_frontend/utils/enums.dart';

class BottomNavigation extends StatelessWidget {
  BottomNavigation({required this.currentTab, required this.onSelectTab});
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        _buildItem(TabItem.keys),
        _buildItem(TabItem.search),
      ],
      onTap: (index) => onSelectTab(
        TabItem.values[index],
      ),
    );
  }

  BottomNavigationBarItem _buildItem(TabItem tabItem) {
    return BottomNavigationBarItem(
      icon: Icon(
        Icons.layers,
        color: _colorTabMatching(tabItem),
      ),
      label: tabName[tabItem],
    );
  }

  MaterialColor? _colorTabMatching(TabItem item) {
    return currentTab == item ? activeTabColor[item] : Colors.grey;
  }
}
