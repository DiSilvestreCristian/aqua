import 'package:aqua/beach_details/map_utils.dart';
import 'package:aqua/model/spiagge_ridotto.dart';
import 'package:aqua/value/colors.dart';
import 'package:aqua/value/numbers.dart';
import 'package:aqua/value/strings.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pollutant_details/pollutant_details.dart';

class BeachDetails extends StatelessWidget {

  final SpiaggiaRidotto spiaggia;

  const BeachDetails({
    Key? key,
    required this.spiaggia,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorItemBackgroundSecondary,
      body: Padding(
          padding: EdgeInsets.only(top: 50.0),
          child: Column(
            children: [
              Container(
                  padding: (EdgeInsets.only(left: 15.0)),
                   child: Align(
                     alignment: Alignment.centerLeft,
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text(
                              spiaggia.comune,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                            ),
                         Text(
                             spiaggia.descrizione,
                             style: TextStyle(fontSize: 16),
                           ),
                       ],
                     ),
                   ),
                ),
              SizedBox(height: 8,),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
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
                                    onTap: () => MapUtils.openMap(spiaggia.coordinate.x as String, spiaggia.coordinate.y as String),
                                  ),
                                ],
                              ),
                            ),
                            CircularPercentIndicator(
                              radius: 250,
                              lineWidth: 25,
                              percent: getPercentage(spiaggia.ostreopsis == null? 0 : spiaggia.ostreopsis, ostreopsisName),
                              progressColor: colorOstreopsis,
                              circularStrokeCap: CircularStrokeCap.round,
                              center: CircularPercentIndicator(
                                radius: 180,
                                lineWidth: 25,
                                percent: getPercentage(spiaggia.escherichia == null? 0 : spiaggia.escherichia, escherichiaName),
                                progressColor: colorEscherichia,
                                circularStrokeCap: CircularStrokeCap.round,
                                center:
                                CircularPercentIndicator(
                                  radius: 110,
                                  lineWidth: 25,
                                  percent: getPercentage(spiaggia.enterococcus == null? 0 : spiaggia.enterococcus, enterococcusName),
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
                                      style: TextStyle(fontSize: 18),),
                                    Text(spiaggia.qualita,
                                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
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
                                      style: TextStyle(fontSize: 18),),
                                    Text(getSituationOstreopsis(spiaggia.ostreopsis == null? -1 : spiaggia.ostreopsis),
                                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(left: 8.0, top: 10.0, right: 8.0),
                          child: Column(
                            children: [
                              GestureDetector(
                                child: Card(
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
                                            Row(
                                              children: [
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Image(
                                                      image: AssetImage('images/icon_ostreopsis.png'),
                                                      height: 40,
                                                      width: 40,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(width: 15.0,),
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
                                                            spiaggia.ostreopsis == null? valoreNonRilevato :spiaggia.ostreopsis.toString(),
                                                            style: TextStyle(fontSize: 40)
                                                        ),
                                                        Text.rich(
                                                          TextSpan(text: spiaggia.ostreopsis == null? "" : sogliaOstreopsis, style: TextStyle(fontSize: 25),
                                                            children:<TextSpan>[
                                                              TextSpan(text: spiaggia.ostreopsis == null? "" : unitaOstreopsis, style: TextStyle(fontSize: 15)),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
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
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return  PollutantDetails(
                                        inquinante: ostreopsisName,
                                        spiaggia: spiaggia,);
                                    }),
                                  );
                                },
                              ),
                              GestureDetector(
                                child: Card(
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
                                          Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Image(
                                                    image: AssetImage('images/icon_escherichia.png'),
                                                    height: 40,
                                                    width: 40,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(width: 15.0,),
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
                                                          spiaggia.escherichia == null? valoreNonRilevato :spiaggia.escherichia.toString(),
                                                          style: TextStyle(fontSize: 40)
                                                      ),
                                                      Text.rich(
                                                        TextSpan(text: spiaggia.escherichia == null? "" : sogliaEscherichia, style: TextStyle(fontSize: 25),
                                                          children:<TextSpan>[
                                                            TextSpan(text: spiaggia.escherichia == null? "" : unitaEscherichia, style: TextStyle(fontSize: 15)),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
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
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return  PollutantDetails(
                                        inquinante: escherichiaName,
                                        spiaggia: spiaggia,);
                                    }),
                                  );
                                },
                              ),
                              GestureDetector(
                                child: Card(
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

                                            Row(
                                              children: [
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Image(
                                                      image: AssetImage('images/icon_enterococcus.png'),
                                                      height: 40,
                                                      width: 40,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(width: 15.0,),
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
                                                            spiaggia.enterococcus == null? valoreNonRilevato :spiaggia.enterococcus.toString(),
                                                            style: TextStyle(fontSize: 40)
                                                        ),
                                                        Text.rich(
                                                          TextSpan(text: spiaggia.enterococcus == null? "" : sogliaEnterococcus, style: TextStyle(fontSize: 25),
                                                            children:<TextSpan>[
                                                              TextSpan(text: spiaggia.enterococcus == null? "" : unitaEnterococcus, style: TextStyle(fontSize: 15)),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
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
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return  PollutantDetails(
                                        inquinante: enterococcusName,
                                        spiaggia: spiaggia,);
                                    }),
                                  );
                                },
                              ),
                            ],
                          )
                      ),
                    ],
                  ),
                )
              )
            ],
          ),
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

  if (val/toleranceLevel == 0) return 0.001;
  if (val/toleranceLevel > 1) return 1;
  return (val/toleranceLevel);
}

String getSituationOstreopsis (int value){
  String situation;
  if (value == -1) situation = notClassifiedSituation;
  else if (value>=0 && value<ostreopsisAllertTheshold) situation = regularSituation;
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