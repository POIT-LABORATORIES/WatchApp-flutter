import 'package:flutter/material.dart';
import 'package:watchapp/screens/Loading.dart';
import 'package:watchapp/services/auth.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.blue[400],
            elevation: 0.0,
            title: Text("Sign up"),
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.person),
                  tooltip: 'Sign in',
                  onPressed: () {
                    widget.toggleView();
                  })
            ]),
        body: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            child: Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Email"
                    ),
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Password"
                    ),
                    obscureText: true,
                    onChanged: (val) {
                      setState(() => password = val);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      }
                      if (value.length < 6) {
                        return 'Password must at least 6 chars long';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        setState(() => loading = true);

                        dynamic authResult = await _auth.
                          registerWithEmailAndPassword(email, password);
                        
                        if (authResult is String) {
                          setState(() => loading = false);

                          ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(authResult)));
                        }
                        if (authResult == null) {
                          setState(() => loading = false);

                          ScaffoldMessenger.of(context)
                            .showSnackBar(
                              SnackBar(
                                content: Text("Something went wrong")
                                )
                            );
                        }
                      }
                    },
                    child: Text("Register"),
                  )
                ]))));
  }
}
