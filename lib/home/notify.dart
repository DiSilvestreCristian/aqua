import 'package:aqua/value/colors.dart';
import 'package:aqua/value/strings.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Notify extends StatefulWidget {
  const Notify({Key? key}) : super(key: key);

  @override
  _NotifyState createState() => _NotifyState();
}

class _NotifyState extends State<Notify> {

  bool _notify = false;
  bool _notifyFavourites = false;
  bool _notifyPosition = false;

  _setNotifyState (String idNotify, bool value) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(idNotify, value);
  }

  Future<bool> _getNotifyState (String idNotify) async{
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getBool(idNotify) ?? false);

  }

  @override
  void initState() {
    super.initState();
    _getNotifyState(idGeneralNotify).then((value){
      if (value == true) {
        setState(() {
          _notify = value;
        });
      }
    });
    _getNotifyState(idFavouritesNotify).then((value){
      if (value == true) {
        setState(() {
          _notifyFavourites = value;
        });
      }
    });
    _getNotifyState(idPositionNotify).then((value){
      if ( value == true) {
        setState(() {
          _notifyPosition = value;
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          SizedBox(height: 60),
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Text(
                  titoloNotifiche,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 45)
                ),
                SizedBox(width: 20,),
                Switch.adaptive(
                  value: _notify,
                  onChanged: (value) => setState(() {
                    this._notify = value;
                    _setNotifyState(idGeneralNotify, value);
                    if(!value){
                      _notifyPosition = value;
                      _notifyFavourites = value;
                      _setNotifyState(idFavouritesNotify, value);
                      _setNotifyState(idPositionNotify, value);
                    }
                  }),
                  activeColor: colorPrimary,
                  inactiveTrackColor: colorSecondary,
                ),
              ],
            ),
          ),
          Visibility(
              visible: _notify,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                   children: [
                     SizedBox(height: 30),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Align(
                             alignment: Alignment.centerLeft,
                             child: Text (
                                 notificaPreferiti,
                                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)
                             )
                         ),
                         Checkbox(
                             value: _notifyFavourites,
                             onChanged: (value) => setState(() {
                               this._notifyFavourites = value!;
                               _setNotifyState(idFavouritesNotify, value);
                             }
                             )
                         )
                       ],
                     ),
                     Align(
                         alignment: Alignment.centerLeft,
                         child: Text (
                             descrizioneNotificaPreferiti,
                             style: TextStyle(fontSize: 17)
                         )
                     ),
                     SizedBox(height: 30),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Flexible(
                             child: Align(
                                 alignment: Alignment.centerLeft,
                                 child: Text (
                                     notificaPosizione,
                                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)
                                 )
                             ),
                           ),
                           Checkbox(
                               value: _notifyPosition,
                               onChanged: (value) => setState(() {
                                    this._notifyPosition = value!;
                                    _setNotifyState(idPositionNotify, value);
                                }
                                )
                           )
                         ],
                       ),
                     SizedBox(height: 8),
                     Align(
                         alignment: Alignment.centerLeft,
                         child: Text (
                             descrizioneNotificaPosizione,
                             style: TextStyle(fontSize: 17)
                         )
                     ),
                  ]
                ),
              )
          )
      ]
    );
  }
}





