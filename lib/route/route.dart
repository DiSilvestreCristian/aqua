import 'package:aqua/UI/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:aqua/route/error_route.dart';
import 'package:aqua/splash_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator{
  static Route<dynamic> generateRoute(RouteSettings settings){

    final args = settings.arguments;

    switch (settings.name){
      case '/splashScreen':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case '/bottomNavBar':
        return MaterialPageRoute(builder: (_) => BottomNavBar());
      default:
        return MaterialPageRoute(builder: (_) => ErrorPage());
    }
  }
}

