import 'package:aqua/value/colors.dart';
import 'package:aqua/value/strings.dart';
import 'package:flutter/material.dart';

class Notify extends StatefulWidget {
  const Notify({Key? key}) : super(key: key);

  @override
  _NotifyState createState() => _NotifyState();
}

class _NotifyState extends State<Notify> {
  bool notify = false;
  bool notifyFavourites = false;
  bool notifyPosition = false;


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
                  value: notify,
                  onChanged: (value) => setState(() => this.notify = value),
                  activeColor: colorPrimary,
                  inactiveTrackColor: colorSecondary,
                ),
              ],
            ),
          ),
          Visibility(
              visible: notify,
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
                             value: notifyFavourites,
                             onChanged: (value) => setState(() => this.notifyFavourites = value!,
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
                               value: notifyPosition,
                               onChanged: (value) => setState(() => this.notifyPosition = value!)
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





