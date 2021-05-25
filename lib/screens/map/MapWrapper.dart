import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watchapp/models/item.dart';
import 'package:watchapp/screens/map/MapPage.dart';

class MapWrapper extends StatefulWidget {
  @override
  _MapWrapperState createState() => _MapWrapperState();
}

class _MapWrapperState extends State<MapWrapper> {
  @override
  Widget build(BuildContext context) {
    final items = Provider.of<List<Item>>(context);

    if (items == null) {
      return MapPage(items: []);
    }
    return MapPage(items: items);
  }
}
