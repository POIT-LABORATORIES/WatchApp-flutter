import 'package:flutter/material.dart';
import 'package:watchapp/services/blocs/preference_bloc.dart';

class PreferenceProvider with ChangeNotifier {
  PreferenceBloc _bloc;

  PreferenceProvider() {
    _bloc = PreferenceBloc();
    _bloc.loadPreferences();
  }

  PreferenceBloc get bloc => _bloc;
}
