import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:folksonomy_dart/folksonomy_dart.dart';
import 'package:flutter/services.dart';
import 'package:folksonomy_frontend/ui/screens/product_page.dart';

class ListPage extends StatefulWidget {
  ListPage({Key? key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final result = <String, KeyStats>{};
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getKeys();
    return result == null
        ? const Center(child: const CircularProgressIndicator())
        : ListView.builder(
            itemCount: (result is Map<String, KeyStats>) ? result.length : 0,
            itemBuilder: (context, index) {
              // print('${result.length}');
              String key = result.keys.elementAt(index);
              return Card(
                  elevation: 8.0,
                  margin:
                      new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                  child: Container(
                      decoration:
                          BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
                      child: ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Products(index: index)));
                          },
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          leading: Container(
                            padding: const EdgeInsets.only(right: 12.0),
                            decoration: const BoxDecoration(
                                border: Border(
                                    right: BorderSide(
                                        width: 1.0, color: Colors.black26))),
                            child: const Icon(
                              Icons.food_bank_rounded,
                              color: Colors.black38,
                              size: 30.0,
                            ),
                          ),
                          title: Text(
                            key,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Keys:${result[key]!.count}",
                                  style: const TextStyle(color: Colors.white)),
                              Text("values:${result[key]!.values}",
                                  style: const TextStyle(color: Colors.white))
                            ],
                          ),
                          trailing: const Icon(Icons.keyboard_arrow_right,
                              color: Colors.black45, size: 30.0))));
            },
          );
  }

  Future<void> getKeys() async {
    var json = await jsonDecode(await getJson());
    for (var element in json) {
      final KeyStats item = KeyStats.fromJson(element);
      result[item.key] = item;
    }
    // result = await FolksonomyAPIClient.getKeys();
    setState(() {
      result;
    });
  }

  Future<String> getJson() async {
    var result;
    try {
      result = await rootBundle.loadString('asset/Keys.json');
    } catch (exception) {
      throw Exception('faild to load $exception');
    }
    return result;
  }
}
