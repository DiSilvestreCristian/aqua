import 'package:aqua/home/homepage.dart';
import 'package:aqua/home/sidebar.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
          children: <Widget> [
            HomaPage(),
            SideBar(),
          ]
    );
  }
}
