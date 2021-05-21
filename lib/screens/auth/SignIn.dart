import 'package:flutter/material.dart';
import 'package:watchapp/services/auth.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.blue[400],
            elevation: 0.0,
            title: Text("Sign in")),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: ElevatedButton(
              onPressed: () async {
                dynamic user = await _auth.signInAnon();
                if (user == null) {
                  print("Error signing in");
                } else {
                  print("Signed in");
                  print(user);
                }
              },
              child: Text("Sign in anonymously")),
        ));
  }
}
