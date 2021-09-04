import 'package:aqua/instance_spiagge.dart';
import 'package:flutter/material.dart';
import 'package:aqua/bottom_nav_bar.dart';
import 'package:singleton/singleton.dart';

void main() {
  Singleton.register(SingletonSpiagge.loadAppSettings());
  Singleton.register(FutureService.createInstance());
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


