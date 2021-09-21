import 'package:aqua/home/searchbar.dart';
import 'package:aqua/home/sidebar.dart';
import 'package:flutter/material.dart';
import 'map.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
          children: <Widget> [
            HomeMap(),
            SearchBar(),
            SideBar(),
          ]
    );
  }
}
