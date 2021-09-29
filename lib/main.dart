import 'package:aqua/route/route.dart';
import 'package:flutter/material.dart';


void main() /*async*/{
  //Singleton.register(SingletonSpiagge.loadAppSettings());
  //Singleton.register(FutureService.createInstance());
  //await Singleton.ensureInstanceFor([SingletonSpiagge(), FutureService]);
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/bottomNavBar',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
