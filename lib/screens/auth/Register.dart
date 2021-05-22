import 'package:flutter/material.dart';
import 'package:watchapp/services/auth.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  Register({ this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  AuthService _auth = AuthService();

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.blue[400],
            elevation: 0.0,
            title: Text("Sign up"),
            actions: <Widget>[
            IconButton(
              icon: Icon(Icons.person),
              tooltip: 'Register',
              onPressed: () {
                widget.toggleView();
              }
            )
            ]),
        body: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            child: Form(
                child: Column(children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                obscureText: true,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () async {
                  print(email);
                  print(password);
                },
                child: Text("Register"),
              )
            ]))));
  }
}