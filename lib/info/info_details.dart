import 'package:aqua/value/colors.dart';
import 'package:aqua/value/strings.dart';
import 'package:flutter/material.dart';

class InfoDetails extends StatelessWidget {

  final String pollutant;

  InfoDetails({
    Key? key,
    required this.pollutant,
  }) : super(key: key);

  Widget build(BuildContext context) {

    Widget infoPollutant ;
    switch (pollutant){
      case ostreopsisName : infoPollutant = InfoOstreopsis();
      break;
      case escherichiaName : infoPollutant = InfoEscherichia();
      break;
      case enterococcusName : infoPollutant = InfoEnterococcus();
      break;
      default : infoPollutant = InfoOstreopsis();
    }

    return Scaffold(
        backgroundColor: colorItemBackgroundSecondary,
        body: Container(
          padding: EdgeInsets.only(top: 50.0, right: 8.0, bottom: 0.0, left: 8.0),
        child: SingleChildScrollView(
          child: Card(
            color: colorItemBackground,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
             child : infoPollutant,
          ),
        )
        )
    );
  }
}

class InfoOstreopsis extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(8.0),
      child: Expanded(
          child: Text.rich (
            ostreopsisInfo,
            style: TextStyle(fontSize: 18),
            softWrap: true,)
      ),
    );
  }
}

class InfoEscherichia extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Expanded(
          child: Text.rich (
            TextSpan(text: escherichiaName, style: TextStyle(fontStyle: FontStyle.italic),
                children:<TextSpan>[
                  TextSpan(text: escherichiaInfo, style: TextStyle(fontStyle: FontStyle.normal)),
                ]
            ),
            style: TextStyle(fontSize: 18),
            softWrap: true,)
      ),
    );
  }
}

class InfoEnterococcus extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Expanded(
          child: Text.rich (
            TextSpan(text: enterococcusName, style: TextStyle(fontStyle: FontStyle.italic),
                children:<TextSpan>[
                  TextSpan(text: enterococcusInfo, style: TextStyle(fontStyle: FontStyle.normal)),
                ]
            ),
            style: TextStyle(fontSize: 18),
            softWrap: true,)
      ),
    );
  }
}
