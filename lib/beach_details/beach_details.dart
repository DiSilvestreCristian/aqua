import 'package:aqua/beach_details/map_utils.dart';
import 'package:aqua/fetch_parse_JSON/spiaggia.dart';
import 'package:aqua/value/colors.dart';
import 'package:aqua/value/numbers.dart';
import 'package:aqua/value/strings.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BeachDetails extends StatelessWidget {

  final Spiaggia spiaggia;

  const BeachDetails({
    Key? key,
    required this.spiaggia,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 50.0),
      child: Column(
        children: [
          Container(
              padding: (EdgeInsets.only(left: 15.0)),
               child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                    spiaggia.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 45),
                  ),
                ),
            ),
          Container(
            height: 260,
            padding: const EdgeInsets.only(left: 18.0, right: 18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 6.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        child: Icon(Icons.place,
                          size: 45,
                          color: colorPrimary,
                        ),
                        onTap: () => MapUtils.openMap(spiaggia.coordinates.x as String, spiaggia.coordinates.y as String),
                      ),
                    ],
                  ),
                ),
                CircularPercentIndicator(
                  radius: 250,
                  lineWidth: 25,
                  percent: getPercentage(spiaggia.ostreopsis[0].value, ostreopsisName),
                  progressColor: colorOstreopsis,
                  circularStrokeCap: CircularStrokeCap.round,
                  center: CircularPercentIndicator(
                    radius: 180,
                    lineWidth: 25,
                    percent: getPercentage(spiaggia.escherichia[0].value, escherichiaName),
                    progressColor: colorEscherichia,
                    circularStrokeCap: CircularStrokeCap.round,
                    center:
                    CircularPercentIndicator(
                      radius: 110,
                      lineWidth: 25,
                      percent: getPercentage(spiaggia.enterococcus[0].value, enterococcusName),
                      progressColor: colorEnterococcus,
                      circularStrokeCap: CircularStrokeCap.round,
                    ),
                  ),
                ),
                Container(
                  width: 50,
                  padding: const EdgeInsets.only(bottom: 6.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FavIcon(id: spiaggia.id)
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 8.0, top: 10.0, right: 8.0),
            child: Column(
              children: [
                Card(
                  color: colorItemBackground,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(qualitaAcqua,
                          style: TextStyle(fontSize: 20),),
                        Text(getQuality(spiaggia.quality),
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                ),
                Card(
                  color: colorItemBackground,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(situazioneAlga,
                          style: TextStyle(fontSize: 20),),
                        Text(getSituationOstreopsis(spiaggia.ostreopsis[0].value),
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(left: 8.0, top: 10.0, right: 8.0),
              child: Column(
                children: [
                  Card(
                    color: colorItemBackground,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Container(
                      height: 100,
                      padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 8.0, bottom: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //!!INSERIRE IMMAGINE ICONA INQUINANTE!!
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text.rich (
                                ostreopsisLabel,
                                  style: TextStyle(
                                      fontSize: 25,
                                  color: colorOstreopsis,
                                  fontWeight: FontWeight.bold)
                              ),
                              Row(
                                children: [
                                  Text(
                                    spiaggia.ostreopsis[0].value.toString(),
                                      style: TextStyle(fontSize: 40)
                                  ),
                                  Text.rich(
                                    TextSpan(text: sogliaOstreopsis, style: TextStyle(fontSize: 25),
                                        children:<TextSpan>[
                                        TextSpan(text: unitaOstreopsis, style: TextStyle(fontSize: 15)),
                                      ],
                                  ),
                              )
                            ],
                          ),
                        ],
                      ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: colorPrimary,
                          ),
                      ]
                    ),
                  )
                  ),
                  Card(
                      color: colorItemBackground,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Container(
                        height: 100,
                        padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 8.0, bottom: 8.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              /* !!INSERIRE IMMAGINE ICONA INQUINANTE!!
                            Image(
                             image: AssetImage('images/icon_ostreopsis.png'),
                              height: 30,
                              width: 30,
                          ),*/
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      escherichiaName,
                                      style: TextStyle(
                                          fontSize: 25,
                                          color: colorEscherichia,
                                          fontWeight: FontWeight.bold)
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                          spiaggia.escherichia[0].value.toString(),
                                          style: TextStyle(fontSize: 40)
                                      ),
                                      Text.rich(
                                        TextSpan(text: sogliaEscherichia, style: TextStyle(fontSize: 25),
                                          children:<TextSpan>[
                                            TextSpan(text: unitaEscherichia, style: TextStyle(fontSize: 15)),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: colorPrimary,
                              ),
                            ]
                        ),
                      )
                  ),
                  Card(
                      color: colorItemBackground,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Container(
                        height: 100,
                        padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 8.0, bottom: 8.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              /* !!INSERIRE IMMAGINE ICONA INQUINANTE!!
                            Image(
                             image: AssetImage('images/icon_ostreopsis.png'),
                              height: 30,
                              width: 30,
                          ),*/
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      enterococcusName,
                                      style: TextStyle(
                                          fontSize: 25,
                                          color: colorEnterococcus,
                                          fontWeight: FontWeight.bold)
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                          spiaggia.enterococcus[0].value.toString(),
                                          style: TextStyle(fontSize: 40)
                                      ),
                                      Text.rich(
                                        TextSpan(text: sogliaEnterococcus, style: TextStyle(fontSize: 25),
                                          children:<TextSpan>[
                                            TextSpan(text: unitaEnterococcus, style: TextStyle(fontSize: 15)),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: colorPrimary,
                              ),
                            ]
                        ),
                      )
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

double getPercentage(int val, String pollutant){
  int toleranceLevel;
  switch(pollutant){
    case ostreopsisName: toleranceLevel = ostreopsisEmergencyTheshold;
    break;
    case escherichiaName: toleranceLevel = escherichiaTheshold;
    break;
    case enterococcusName: toleranceLevel = enterococcusTheshold;
    break;
    default: toleranceLevel = ostreopsisEmergencyTheshold;
  }

  if (val/toleranceLevel == 0) return 0.1;
  if (val/toleranceLevel > 1) return 1;
  return (val/toleranceLevel);
}

String getQuality (String value){
String quality;
switch(value){
  case qualityJSONBad: quality = qualityBad;
  break;
  case qualityJSONSufficient: quality = qualitySufficient;
  break;
  case qualityJSONGood: quality = qualityGood;
  break;
  case qualityJSONExelent: quality = qualityExelent;
  break;
  default: quality = qualityExelent;
}
return quality;
}

String getSituationOstreopsis (int value){
  String situation;
  if (value>=0 && value<ostreopsisAllertTheshold) situation = regularSituation;
  else if (value>=ostreopsisAllertTheshold && value<ostreopsisEmergencyTheshold) situation = allertSituation;
  else (situation=emergencySituation);
  return situation;
}

class FavIcon extends StatefulWidget {

  final String id;

  FavIcon({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _FavIconState createState() => _FavIconState();
}

class _FavIconState extends State<FavIcon> {

  IconData _icon = Icons.favorite_border;

  _setFavourites() async{
    final prefs = await SharedPreferences.getInstance();

    if (await _getFavValue() == 0) {
      prefs.setInt(widget.id, 1);
      _setIcon();
    }
    else {
      prefs.setInt(widget.id, 0);
      _setIcon();
    }
  }

  Future<int> _getFavValue () async{
    final prefs = await SharedPreferences.getInstance();

    final value = (prefs.getInt(widget.id) ?? 0);
    return value;
  }

  _setIcon () async {
    if (await _getFavValue() == 0) {
      setState(() {
        _icon = Icons.favorite_border;
      });
    } else {
      setState(() {
        _icon = Icons.favorite;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _setIcon();
    return  GestureDetector(
        child: Icon(_icon,
          size: 45,
          color: colorPrimary,
        ),
        onTap: (){
          _setFavourites();
        },
    );
  }
}