import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ItemList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'Basic List';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('Phone'),
            ),
          ],
        ),
      ),
    );
  }
}