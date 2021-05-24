import 'package:flutter/material.dart';
import 'package:watchapp/models/item.dart';

class ItemDetail extends StatelessWidget {
  ItemDetail({ this.item });

  final Item item;
  final ScrollController _controllerOne = ScrollController();

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
      body: Scrollbar(
        controller: _controllerOne,
        child: Center(
          child: Column(
            children: <Widget>[
              Image.network(
                item.avatarUrl,
                height: 200.0,
                fit: BoxFit.scaleDown
              ),
              Text(item.name),
              Text(item.style),
              Text(item.description),
            ],
          ),
        )
      ),
      /*
      body: Center(
        child: Column(
          children: <Widget>[
            Image.network(
              item.avatarUrl,
              height: 200.0,
              fit: BoxFit.scaleDown
            ),
            Text(item.name),
            Text(item.style),
            Text(item.description),
          ],
        ),
      )
      */
    );
  }
}
