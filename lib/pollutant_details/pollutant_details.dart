import 'package:aqua/pollutant_details/grafico_storico.dart';
import 'package:aqua/value/colors.dart';
import 'package:aqua/value/numbers.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../value/strings.dart';
import '../value/colors.dart';
import '../services/services_storico.dart';
import '../model/spiagge_ridotto.dart';
import '../model/storico.dart';

class PollutantDetails extends StatefulWidget {
  final SpiaggiaRidotto spiaggia;
  final String inquinante;

  const PollutantDetails(
      {Key? key, required this.spiaggia, required this.inquinante})
      : super(key: key);

  @override
  _PollutantDetailsState createState() => _PollutantDetailsState();
}

class _PollutantDetailsState extends State<PollutantDetails> {
  List<Rilevazione> _storico = [];

  late AssetImage iconPollutant;
  late TextSpan namePollutant;
  late Color colorPollutant;

  late int currentMonth, secondMonth, thirdMonth;

  late String valoreAttuale, soglia, unitaMisura;

  int getMedia(int month) {
    int count = 0;
    int tot = 0;
    for (Rilevazione elem in _storico) {
      if (elem.data.month == month) {
        tot += elem.value;
        count++;
      }
    }
    return (tot / count).toInt();
  }

  double getPercentageMedia(int month) {
    int theshold = 0;
    switch (widget.inquinante) {
      case ostreopsisName:
        theshold = ostreopsisEmergencyTheshold;
        break;
      case escherichiaName:
        theshold = escherichiaTheshold;
        break;
      case enterococcusName:
        theshold = enterococcusTheshold;
        break;
    }
    int media = getMedia(month);
    num percentage = media <= theshold ? media / theshold : 1;
    return percentage.toDouble();
  }

  String getMonthName(int month) {
    return nomiMesi[month - 1];
  }

  @override
  void initState() {
    super.initState();

    switch (widget.inquinante) {
      case ostreopsisName:
        {
          iconPollutant = AssetImage('images/icon_ostreopsis.png');
          namePollutant = ostreopsisLabel;
          colorPollutant = colorOstreopsis;
          soglia = sogliaOstreopsis;
          unitaMisura = unitaOstreopsis;
          break;
        }
      case escherichiaName:
        {
          iconPollutant = AssetImage('images/icon_escherichia.png');
          namePollutant = TextSpan(
              text: escherichiaName,
              style: TextStyle(fontStyle: FontStyle.normal));
          colorPollutant = colorEscherichia;
          soglia = sogliaEscherichia;
          unitaMisura = unitaEscherichia;
          break;
        }
      case enterococcusName:
        {
          iconPollutant = AssetImage('images/icon_enterococcus.png');
          namePollutant = TextSpan(
              text: enterococcusName,
              style: TextStyle(fontStyle: FontStyle.normal));
          colorPollutant = colorEnterococcus;
          soglia = sogliaEnterococcus;
          unitaMisura = unitaEnterococcus;
          break;
        }
    }

    ServicesStorico.getStorico().then((storico) {
      setState(() {
        _storico = new List<Rilevazione>.from(storico);
        _storico.sort((a, b) => a.data.compareTo(b.data));

        currentMonth = storico[0].data.month;

        for (Rilevazione elem in storico) {
          if (elem.data.month != currentMonth) {
            secondMonth = elem.data.month;
            break;
          }
        }

        for (Rilevazione elem in storico) {
          if (elem.data.month != currentMonth &&
              elem.data.month != secondMonth) {
            thirdMonth = elem.data.month;
            break;
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.only(top: 50.0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: (EdgeInsets.only(left: 15.0)),
                  child: Text(
                    widget.spiaggia.comune,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 45),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Row(
                  children: [
                    Image(
                      image: iconPollutant,
                      height: 40,
                      width: 40,
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Text.rich(namePollutant,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Expanded(
                child: SingleChildScrollView(
                    physics: ScrollPhysics(),
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Card(
                            color: colorItemBackground,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: 15.0, top: 5.0, bottom: 5.0),
                              height: 100,
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(labelSituazioneAttuale,
                                        style: TextStyle(
                                            color: colorPollutant,
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold)),
                                    Row(
                                      children: [
                                        Text(_storico[0].value.toString(),
                                            style: TextStyle(
                                              fontSize: 40,
                                            )),
                                        Text.rich(
                                          TextSpan(
                                            text: soglia,
                                            style: TextStyle(fontSize: 25),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: unitaMisura,
                                                  style:
                                                      TextStyle(fontSize: 15)),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ]),
                            )),
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Card(
                            color: colorItemBackground,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: 15.0,
                                  top: 5.0,
                                  right: 15.0,
                                  bottom: 8.0),
                              height: 260,
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(labelMedieMensili,
                                        style: TextStyle(
                                            color: colorPollutant,
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                      getMonthName(currentMonth),
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    LinearPercentIndicator(
                                      percent: getPercentageMedia(currentMonth)
                                          .toDouble(),
                                      animation: false,
                                      backgroundColor:
                                          colorLinearProgressBarBackground,
                                      progressColor: colorPollutant,
                                      lineHeight: 25,
                                    ),
                                    Text(
                                      getMonthName(secondMonth),
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    LinearPercentIndicator(
                                      percent: getPercentageMedia(secondMonth)
                                          .toDouble(),
                                      animation: false,
                                      backgroundColor:
                                          colorLinearProgressBarBackground,
                                      progressColor: colorPollutant,
                                      lineHeight: 25,
                                    ),
                                    Text(
                                      getMonthName(thirdMonth),
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    LinearPercentIndicator(
                                      percent: getPercentageMedia(thirdMonth)
                                          .toDouble(),
                                      animation: false,
                                      backgroundColor:
                                          colorLinearProgressBarBackground,
                                      progressColor: colorPollutant,
                                      lineHeight: 25,
                                    ),
                                  ]),
                            )),
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 25.0),
                          child: Text(labelStoricoValori,
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      Container(
                          height: 200,
                          child: GraficoStorico(
                            storico: _storico.reversed.toList(),
                            colorPollutant: colorPollutant,
                          )),
                      MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            itemCount: null == _storico ? 0 : _storico.length,
                            itemBuilder: (context, index) {
                              Rilevazione elem = _storico[index];
                              return ListTile(
                                  title: Container(
                                padding: EdgeInsets.symmetric(horizontal: 15.0),
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: colorItemBackground,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text: elem.value.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold, fontSize: 23.0, color: colorTextPrimary),
                                        children: <TextSpan>[
                                          TextSpan(text: '${soglia}${unitaMisura}',
                                              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18.0)),
                                        ],
                                      ),
                                    ),
                                    Text("${elem.data.day}/${elem.data.month}/${elem.data.year}",
                                      style: TextStyle(fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ));
                            }),
                      ),
                    ])),
              ),
            ])));
  }
}
