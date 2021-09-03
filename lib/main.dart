import 'package:aqua/instance_spiagge.dart';
import 'package:flutter/material.dart';
import 'package:aqua/bottom_nav_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BottomNavBar(),
    );
  }
}


