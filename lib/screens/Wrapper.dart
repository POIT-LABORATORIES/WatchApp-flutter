import 'package:flutter/material.dart';
import 'package:watchapp/screens/auth/Authenticate.dart';
import 'package:watchapp/screens/home/Home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Return Home or Authenticate.
    return Authenticate();
  }
}
