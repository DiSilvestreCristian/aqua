import 'package:aqua/value/colors.dart';
import 'package:aqua/value/strings.dart';
import 'package:flutter/material.dart';

class InfoDetails extends StatefulWidget {

  final String pollutant;

  InfoDetails({
    Key? key,
    required this.pollutant,
  }) : super(key: key);

  @override
  State<InfoDetails> createState() => _InfoDetailsState();
}

class _InfoDetailsState extends State<InfoDetails> {

  late  Widget infoPollutant ;

  @override
  void initState() {
    super.initState();
    switch (widget.pollutant){
      case ostreopsisName : setState(() {
        infoPollutant = InfoOstreopsis();
      });
      break;
      case escherichiaName : setState(() {
        infoPollutant = InfoEscherichia();
      });
      break;
      case enterococcusName : setState(() {
        infoPollutant = InfoEnterococcus();
      });
      break;
      default : setState(() {
        infoPollutant = InfoOstreopsis();
      });
    }
  }

  Widget build(BuildContext context) {

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
            TextSpan(text: escherichiaName, style: TextStyle(fontStyle: FontStyle.italic, color: colorTextPrimary),
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
            TextSpan(text: enterococcusName, style: TextStyle(fontStyle: FontStyle.italic, color: colorTextPrimary),
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
