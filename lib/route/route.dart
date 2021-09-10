import 'package:aqua/favourites/favourites.dart';
import 'package:aqua/info/info.dart';
import 'package:aqua/rank.dart';
import 'package:aqua/route/error_route.dart';
import 'package:flutter/material.dart';
import 'package:aqua/main.dart';
import '../bottom_nav_bar/bottom_nav_bar.dart';
import '../home/homepage.dart';

class RouteGenerator{
  static Route<dynamic> generateRoute(RouteSettings settings){

    final args = settings.arguments;

    switch (settings.name){
      case '/bottomNavBar':
        return MaterialPageRoute(builder: (_) => BottomNavBar());
      case '/home':
        return MaterialPageRoute(builder: (_) => HomePage());
      case '/favourites':
        return MaterialPageRoute(builder: (_) => Favourites());
      case '/rank':
        return MaterialPageRoute(builder: (_) => Rank());
      case '/info':
        return MaterialPageRoute(builder: (_) => Info());
      default:
        return MaterialPageRoute(builder: (_) => ErrorPage());
    }
  }
}

