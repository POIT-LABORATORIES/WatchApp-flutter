import 'package:flutter/material.dart';
import 'package:watchapp/services/auth.dart';

class ItemList extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final title = 'Watch list';

    return Scaffold(
      appBar: AppBar(
          title: Text(title),
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.login_rounded),
              onPressed: () async {
                await _auth.signOut();
              }
            )
          ]
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.phone),
            title: Text('Phone'),
          ),
        ],
      ),
    );
  }
}
