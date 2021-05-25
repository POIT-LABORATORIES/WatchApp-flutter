import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:latlong/latlong.dart';
import 'package:watchapp/models/item.dart';
import 'package:watchapp/screens/Loading.dart';

class MapPage extends StatefulWidget {
  final List<Item> items;

  MapPage({this.items});

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
            //builder: (_) => Icon(Icons.location_on, size: _markerSize),
            builder: (_) => Container(
              child: IconButton(
                icon: Icon(Icons.location_on,
                    size: _markerSize, color: Colors.blue),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (builder) {
                      return Container(
                        child: Text(item.name),
                      );
                    });
                },
              ),
            ),
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

    return FlutterMap(
      options: MapOptions(
        zoom: 10.0,
        center: LatLng(0, 0),
        onTap: (_) => _popupLayerController
            .hidePopup(), // Hide popup when the map is tapped.
      ),
      layers: [
        MarkerLayerOptions(
          markers: _markers,
        ),
      ],
      children: [
        TileLayerWidget(
          options: TileLayerOptions(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
        ),
        /*
        PopupMarkerLayerWidget(
          options: PopupMarkerLayerOptions(
            markers: _markers,
            popupSnap: PopupSnap.markerTop,
            popupController: _popupLayerController,
            popupBuilder: (context, marker) {
              return null;
            },
            //MapPopup(marker),
            popupAnimation: PopupAnimation.fade(
              duration: Duration(milliseconds: 700),
            ),
          ),
        ),
        */
      ],
    );
  }
}
