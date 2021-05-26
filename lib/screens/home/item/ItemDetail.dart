import 'package:flutter/material.dart';
import 'package:watchapp/models/item.dart';
import 'package:watchapp/screens/home/item/ItemDetailSheet.dart';

class ItemDetail extends StatelessWidget {
  ItemDetail({this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.name), 
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever),
            tooltip: 'Delete item',
            onPressed: () {
              // Make a call to delete function!
            })
        ],
      ),
      body: SingleChildScrollView(
        child: ItemDetailSheet(item: item),
      ),
    );
  }
}
