import 'package:flutter/material.dart';
import 'package:watchapp/models/user.dart';
import 'package:watchapp/screens/utilities/Loading.dart';
import 'package:watchapp/screens/Wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:watchapp/services/auth.dart';
import 'package:watchapp/services/providers/preference_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatefulWidget {
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Show error message if initialization failed
    if (_error) {
      print(_error);
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      return Loading();
    }

    return ChangeNotifierProvider(
      create: (BuildContext context) => PreferenceProvider(),
      child: Consumer<PreferenceProvider>(
        builder: (context, provider, child) {
          return StreamProvider<User>.value(
            value: AuthService().user,
            initialData: null,
            child: StreamBuilder<Brightness>(
              stream: provider.bloc.brightness,
              builder: (context, snapshot) {
                return MaterialApp(
                  theme: ThemeData(
                    primarySwatch: Colors.green,
                    brightness: snapshot.data,
                    textTheme: TextTheme(
                      
                    ),
                  ),
                  home: Wrapper()
                );
              }
            ),
          );
        },
      ),
    );
  }
}