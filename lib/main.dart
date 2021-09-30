import 'package:aqua/route/route.dart';
import 'package:flutter/material.dart';


void main() {

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
