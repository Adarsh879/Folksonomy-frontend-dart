import 'package:flutter/material.dart';

class Products extends StatefulWidget {
  Products({Key? key, required this.index}) : super(key: key);
  int index;
  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  late List<Map<String, String>> list;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    list = products.elementAt(widget.index);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        Map<String, String> map = list[index];
        return Card(
            elevation: 8.0,
            margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            child: Container(
                decoration:
                    BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
                child: ListTile(
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
                      map['product']!,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Keys:${map['key']}",
                            style: const TextStyle(color: Colors.white)),
                        Text("value:${map['value']}",
                            style: const TextStyle(color: Colors.white))
                      ],
                    ),
                    trailing: const Icon(Icons.keyboard_arrow_right,
                        color: Colors.black45, size: 30.0))));
      },
    );
  }

  static const List<List<Map<String, String>>> products = [
    [
      {'product': '543636346', 'key': 'color', 'value': 'yellow'},
      {'product': '63636363636', 'key': 'color', 'value': 'hrhrshsh'},
      {'product': '879372516', 'key': 'color', 'value': 'yhjshsg'}
    ],
    [
      {'product': '543636346', 'key': 'package:character', 'value': 'yes'},
      {'product': '63636363636', 'key': 'package:character', 'value': 'yes'},
      {'product': '879372516', 'key': 'package:character', 'value': 'yes'},
    ],
    [
      {'product': '543636346', 'key': 'xyz', 'value': '3456fg'},
      {'product': '63636363636', 'key': 'xyz', 'value': 'greg'},
      {'product': '879372516', 'key': 'xyz', 'value': 'gety'},
    ]
  ];
}
