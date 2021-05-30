import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watchapp/services/providers/preference_provider.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<PreferenceProvider>(context).bloc;

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await bloc.savePreferences();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Settings are saved")
            )
          );
        },
        tooltip: 'Save settings',
        icon: Icon(Icons.settings),
        label: Text("Save settings"),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Light Mode"),
              StreamBuilder<Brightness>(
                  stream: bloc.brightness,
                  builder: (context, snapshot) {
                    return Switch(
                      onChanged: (bool value) {
                        if (value) {
                          bloc.changeBrightness(Brightness.light);
                        } else {
                          bloc.changeBrightness(Brightness.dark);
                        }
                      },
                      value: (snapshot.data == Brightness.light) ? true : false,
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
