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
      body: GridView.count(
        crossAxisCount: 2,
        children: <Widget>[
          Card(
            elevation: 1.0,
            child: Container(
              child: Text("Item 1")
            ),
          ),
          Card(
            elevation: 1.0,
            child: Column(
              children: <Widget>[
                Image
                .network("https://firebasestorage.googleapis.com/v0/b/watch-app-76470.appspot.com/o/images%2FAlpina%20AL-525G4TS6-avatar?alt=media&token=b946525c-46a7-4c23-b719-c41c2b5d3591",
                height: 130.0,
                fit: BoxFit.scaleDown),
                SizedBox(
                  height: 5.0
                ),
                Text("Some watch rherthrth thtrhtrh trhsthgtsrh"),
              ],
            ),
          ),
        ],
      )
      /*
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.phone),
            title: Text('Phone'),
          ),
          ListTile(
            leading: Icon(Icons.car_repair),
            title: Text('Car repair'),
          ),
        ],
      ),
      */
    );
  }
}
