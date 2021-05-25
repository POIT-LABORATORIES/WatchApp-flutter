import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:latlong/latlong.dart';
import 'package:watchapp/models/item.dart';
import 'package:watchapp/screens/Loading.dart';

class MapPage extends StatefulWidget {
  final List<Item> items;

  MapPage({ this.items });

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  List<Marker> _markers;
  static const _markerSize = 40.0;

  // Used to trigger showing/hiding of popups.
  final PopupController _popupLayerController = PopupController();

  @override
  void initState() {
    super.initState();

    _markers = widget.items
        .map(
          (Item item) => Marker(
            point: LatLng(item.latitude, item.longitude),
            width: _markerSize,
            height: _markerSize,
            builder: (_) => Icon(Icons.location_on, size: _markerSize),
            anchorPos: AnchorPos.align(AnchorAlign.top),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items == null) {
      return Loading();
    }

    return Container();
  }
}
