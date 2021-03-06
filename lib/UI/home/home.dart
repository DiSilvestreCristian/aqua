import 'package:aqua/UI/home/homepage.dart';
import 'package:aqua/UI/home/sidebar.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Stack(
            children: <Widget> [
              HomaPage(),
              SideBar(),
            ]
      ),
      onWillPop: () {
        return Future.value(false);
      },
    );
  }
}
