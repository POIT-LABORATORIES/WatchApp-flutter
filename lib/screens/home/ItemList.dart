import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watchapp/models/item.dart';
import 'package:watchapp/screens/utilities/Loading.dart';
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
    } else {
      print("");
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
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ItemCreate()));
        },
        child: Icon(Icons.add_circle),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
