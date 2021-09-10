import 'package:aqua/fetch_parse_JSON/instance_spiagge.dart';
import 'package:aqua/route/route.dart';
import 'package:flutter/material.dart';
import 'package:singleton/singleton.dart';

void main() /*async*/{
  //Singleton.register(SingletonSpiagge.loadAppSettings());
  //Singleton.register(FutureService.createInstance());
  //await Singleton.ensureInstanceFor([SingletonSpiagge(), FutureService]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/bottomNavBar',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}


