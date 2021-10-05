import 'package:aqua/route/route.dart';
import 'package:aqua/services/services_storico.dart';
import 'package:aqua/value/numbers.dart';
import 'package:aqua/value/strings.dart';
import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'model/instance_spiagge.dart';
import 'model/spiagge_ridotto.dart';

Future<bool> _getNotifyValue () async{
  final prefs = await SharedPreferences.getInstance();
  var value = (prefs.getBool(idFavouritesNotify) ?? false);
  return value;
}

Future<int> _getFavValue (String id) async{
  final prefs = await SharedPreferences.getInstance();
  var value = (prefs.getInt(id) ?? 0);
  return value;
}

Future<List<SpiaggiaRidotto>> getSingleton(){
  var singleton = new SingletonSpiagge();
  final spiagge = singleton.spiagge;
  return spiagge;
}



void callbackDispatcher()async {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager.executeTask((taskName, inputData) {
    switch (taskName){
      case taskFavouritesNotification : {
        bool alarmOstreopsis = false, alarmEscherichia = false, alarmEnterococcus = false;
        _getNotifyValue().then((value){
          if(value){
            getSingleton().then((spiagge){
              for (SpiaggiaRidotto elem in spiagge){
                _getFavValue(elem.id).then((value){
                  if (value == 1){
                    ServicesStorico.getStorico(ostreopsisName, elem.id).then((storico) {
                      storico.sort((a, b) => a.data.compareTo(b.data));
                      if (storico[0].data.isAfter(DateTime.now().subtract(new Duration(days: 1))) &&
                          (storico[0].value) >= ostreopsisEmergencyTheshold){
                        alarmOstreopsis = true;
                      }
                    });
                    ServicesStorico.getStorico(escherichiaName, elem.id).then((storico) {
                      storico.sort((a, b) => a.data.compareTo(b.data));
                      if (storico[0].data.isAfter(DateTime.now().subtract(new Duration(days: 1))) &&
                          (storico[0].value) >= escherichiaTheshold){
                        alarmEscherichia = true;
                      }
                    });
                    ServicesStorico.getStorico(enterococcusName, elem.id).then((storico) {
                      storico.sort((a, b) => a.data.compareTo(b.data));
                      if (storico[0].data.isAfter(DateTime.now().subtract(new Duration(days: 1))) &&
                          (storico[0].value) >= enterococcusTheshold){
                        alarmEnterococcus = true;
                      }
                    });
                    //send notify
                  }
                });
              }
            });
          }
        });

        break;
      }
      case taskPositionNotification : {
        break;
      }
    }
    return Future.value(true);
  });
}

void main() {
  /*WidgetsFlutterBinding.ensureInitialized();
  Workmanager.initialize(callbackDispatcher,
      isInDebugMode: false);
  Workmanager.registerPeriodicTask(
      taskFavouritesNotification, taskFavouritesNotification,
      frequency: Duration(days: 1),
      initialDelay: Duration(minutes: 1)
  );*/
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
