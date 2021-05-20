import 'package:flutter/material.dart';
import 'ItemList.dart';

class TabNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.green),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.list)),
                Tab(icon: Icon(Icons.map)),
                Tab(icon: Icon(Icons.settings)),
              ],
            ),
            title: Text('Tabs Demo'),
          ),
          body: TabBarView(
            children: [
              ItemList(),
              Icon(Icons.map),
              Icon(Icons.settings),
            ],
          ),
        ),
      ),
    );
  }
}
