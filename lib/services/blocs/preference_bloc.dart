import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceBloc {
  static final String light_mode = 'light_mode';

  final _brightness = BehaviorSubject<Brightness>();

  Stream<Brightness> get brightness => _brightness.stream;

  Function(Brightness) get changeBrightness => _brightness.sink.add;

  savePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_brightness.value == Brightness.light) {
      await prefs.setBool('light_mode', true);
    } else {
      await prefs.setBool('light_mode', false);
    }
  }

  loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool lightMode = prefs.get('light_mode');

    if (lightMode != null) {
      (lightMode == false)
          ? changeBrightness(Brightness.dark)
          : changeBrightness(Brightness.light);
    } else {
      changeBrightness(Brightness.dark);
    }
  }

  dispose() {
    _brightness.close();
  }
}
