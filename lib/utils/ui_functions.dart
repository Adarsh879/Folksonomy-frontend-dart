import 'package:flutter/material.dart';

class GestureFunctions {
  void _push(BuildContext context, Widget page) {
    Navigator.of(context).push(MaterialPageRoute(
      // we'll look at ColorDetailPage later
      builder: (context) => page,
    ));
  }
}
