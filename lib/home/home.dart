import 'package:aqua/home/sidebar.dart';
import 'package:flutter/material.dart';

import 'homepage.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
          children: <Widget> [
            HomePage(),
            SideBar(),
          ]
    );
  }
}
