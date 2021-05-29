import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watchapp/models/item.dart';
import 'package:watchapp/screens/home/ItemList.dart';
import 'package:watchapp/services/database.dart';
import 'package:watchapp/screens/map/MapWrapper.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    ItemList(),
    MapWrapper(),
    Text(
      'Index 2: Settings',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Item>>.value(
      value: DatabaseService(FirestoreCollectionKey.watches).items,
      initialData: null,
      child: Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.view_list),
              label: 'List',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map_sharp),
              label: 'Map',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_applications_sharp),
              label: 'Settings',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
