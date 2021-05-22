import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watchapp/models/user.dart';
import 'package:watchapp/screens/auth/Authenticate.dart';
import 'package:watchapp/screens/home/Home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user == null) {
      return Authenticate();
    }
    return Home();
  }
}
