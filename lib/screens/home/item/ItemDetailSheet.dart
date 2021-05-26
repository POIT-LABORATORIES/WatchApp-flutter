import 'package:flutter/material.dart';
import 'package:watchapp/models/item.dart';

class ItemDetailSheet extends StatelessWidget {
  const ItemDetailSheet({
    Key key,
    this.item,
  }) : super(key: key);

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(22.0),
          child: Column(
            children: <Widget>[
              Image.network(item.avatarUrl,
                  height: 200.0, fit: BoxFit.scaleDown),
              SizedBox(height: 20.0),
              Text("Name: " + item.name),
              SizedBox(height: 20.0),
              Text("Style: " + item.style),
              SizedBox(height: 20.0),
              Text("Case color: " + item.caseColor),
              SizedBox(height: 20.0),
              Text("Latitude: " + item.latitude.toString()),
              SizedBox(height: 20.0),
              Text("Longitude: " + item.longitude.toString()),
              SizedBox(height: 20.0),
              Text("Description: " + item.description),
            ],
          ),
        ),
      ),
    );
  }
}