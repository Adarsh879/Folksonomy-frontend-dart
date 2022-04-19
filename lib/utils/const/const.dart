import 'package:flutter/material.dart';
import '../enums.dart';

const Map<TabItem, String> tabName = {
  TabItem.keys: 'Keys',
  TabItem.search: 'Search',
};

const Map<TabItem, MaterialColor> activeTabColor = {
  TabItem.keys: Colors.red,
  TabItem.search: Colors.blue,
};
