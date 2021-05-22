import 'package:flutter/material.dart';
import 'package:watchapp/services/auth.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.blue[400],
            elevation: 0.0,
            title: Text("Sign in"),
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
                      return null;
                    },
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        dynamic authResult =
                          await _auth.signInWithEmailAndPassword(email, password);
                        
                        if (authResult is String) {
                          ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(authResult)));
                        }
                        if (authResult == null) {
                          ScaffoldMessenger.of(context)
                            .showSnackBar(
                              SnackBar(
                                content: Text("Something went wrong")
                                )
                            );
                        }

                        ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("Authorizing...")));
                      }
                    },
                    child: Text("Sign in"),
                  )
                ]))));
  }
}
