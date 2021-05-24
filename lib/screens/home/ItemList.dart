import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watchapp/models/item.dart';
import 'package:watchapp/screens/Loading.dart';
import 'package:watchapp/screens/home/item/ItemCreate.dart';
import 'package:watchapp/screens/home/item/ItemDetail.dart';
import 'package:watchapp/services/auth.dart';

class ItemList extends StatefulWidget {
  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final title = 'Watch list';

    final items = Provider.of<List<Item>>(context);
    if (items == null) {
      return Loading();
    }

    return Scaffold(
        appBar: AppBar(title: Text(title), elevation: 0.0, actions: <Widget>[
          IconButton(
              icon: Icon(Icons.login_rounded),
              onPressed: () async {
                await _auth.signOut();
              })
        ]),
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(items[index].name),
              subtitle: Text(items[index].style),
              leading:
                  Image.network(items[index].avatarUrl, fit: BoxFit.scaleDown),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ItemDetail(item: items[index])));
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => ItemCreate()
            ));
            
          },
          child: Icon(Icons.add_circle),
          backgroundColor: Colors.blue,
        ),
        /*
        body: GridView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 1.0,
              child: Column(
                children: <Widget>[
                  Image.network(items[index].avatarUrl,
                      height: 130.0,
                      fit: BoxFit.scaleDown),
                  SizedBox(height: 5.0),
                  Text(items[index].name),
                ],
              ),
            );
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 5.0,
            mainAxisSpacing: 5.0,
          ),
        )
        */
        );
  }
}
