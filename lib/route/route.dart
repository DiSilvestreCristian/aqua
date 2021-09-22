import 'package:aqua/route/error_route.dart';
import 'package:flutter/material.dart';
import '../bottom_nav_bar/bottom_nav_bar.dart';

class RouteGenerator{
  static Route<dynamic> generateRoute(RouteSettings settings){

    final args = settings.arguments;

    switch (settings.name){
      case '/bottomNavBar':
        return MaterialPageRoute(builder: (_) => BottomNavBar());
      default:
        return MaterialPageRoute(builder: (_) => ErrorPage());
    }
  }
}

