import 'package:flutter/material.dart';

import 'instance_spiagge.dart';
import 'model/spiagge_ridotto.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  Future<List<SpiaggiaRidotto>> getSingleton(){
    var singleton = new SingletonSpiagge();
    final spiagge = singleton.spiagge;
    return spiagge;
  }
  @override
  void initState() {
    super.initState();
    getSingleton().then((spiagge){
      Navigator.pushNamed( context,
        '/bottomNavBar',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: Center(
          child: Image(
            image: AssetImage('images/logo.png'),
              height: 130,
              width: 130,
          ),
        )
      ),
      onWillPop: () {
        return Future.value(false);
      },
    );
  }
}
