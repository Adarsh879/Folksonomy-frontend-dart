import 'dart:convert';
import 'dart:io';

import 'package:folksonomy_dart/src/api.dart';
import 'package:folksonomy_dart/src/model/product_stats.dart';
import 'package:folksonomy_dart/src/model/product_tag.dart';
import 'package:folksonomy_dart/src/utils/QueryType.dart';

import 'model/KeyStats.dart';

void main() async {
  // print("Enter use-id: ");
  // final String? user = stdin.readLineSync(encoding: utf8);
  // print("Enter password: ");
  // final String? password = stdin.readLineSync(encoding: utf8);
  // Map<String, dynamic> data =
  //     await FolksonomyAPIClient.authenticate(user!, password!, QueryType.PROD);
  // // await FolksonomyAPIClient.addProductTag(
  // //   '8901725119959',
  // //   'color',
  // //   'yellow',
  // //   data['access_token'] as String,
  // // );
  // Map<String, ProductTag> list = await FolksonomyAPIClient.getProductTags(
  //     barcode: '8901725119959',
  //     // );
  //     owner: 'adarsh',
  //     token: data['access_token'] as String);
  // Map<String, KeyStats> list = await FolksonomyAPIClient.getKeys();
  // print(list);
  KeyStats stats = KeyStats(key: 'color', count: 1, values: 1);
  print(stats.toJson());
}
