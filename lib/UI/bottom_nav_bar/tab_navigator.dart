import 'package:aqua/UI/home/home.dart';
import 'package:aqua/UI/rank.dart';
import 'package:flutter/material.dart';
import '../favourites/favourites.dart';
import '../info/info.dart';

class TabNavigator extends StatelessWidget {
  TabNavigator({required this.navigatorKey, required this.tabItem});
  final GlobalKey<NavigatorState> navigatorKey;
  final String tabItem;

  @override
  Widget build(BuildContext context) {

    Widget child ;
    if(tabItem == "Home")
      child = Home();
    else if(tabItem == "Favourites")
      child = Favourites();
    else if(tabItem == "Rank")
      child = Rank();
    else
      child = Info();


    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
            builder: (context) => child
        );
      },
    );
  }
}