import 'package:flutter/material.dart';
import 'package:aqua/bottom_nav_bar.dart';
import 'package:aqua/home.dart';
import 'package:aqua/info_details.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/home',
      routes: {
        '/home': (context) => BottomNavBar(),
        '/info_details': (context) => InfoDetails(),
      },
      home: BottomNavBar(),
    );
  }
}
