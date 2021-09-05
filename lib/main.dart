import 'package:aqua/fetch_parse_JSON/instance_spiagge.dart';
import 'package:aqua/route/route.dart';
import 'package:flutter/material.dart';
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
      initialRoute: '/bootomNavBar',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}


