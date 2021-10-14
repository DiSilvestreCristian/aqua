import 'package:aqua/model/storico.dart';
import 'package:aqua/value/colors.dart';
import 'package:aqua/value/numbers.dart';
import 'package:aqua/value/strings.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'grafico_storico.dart';

class Storico extends StatefulWidget {
  final String valoreAttuale;
  final List<Rilevazione> storico;
  final String inquinante, soglia, unitaMisura;
  final Color colorPollutant;


  const Storico(
      {Key? key,
        required this.valoreAttuale,
        required this.storico,
        required this.inquinante,
        required this.soglia,
        required this.unitaMisura,
        required this.colorPollutant})
      : super(key: key);

  @override
  _StoricoState createState() => _StoricoState();
}

class _StoricoState extends State<Storico> {

  late int currentMonth, secondMonth, thirdMonth;

  int getMedia(int month) {
    int count = 0;
    int tot = 0;
    for (Rilevazione elem in widget.storico) {
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

    currentMonth = widget.storico[0].data.month;

    for (Rilevazione elem in widget.storico) {
      if (elem.data.month != currentMonth) {
        secondMonth = elem.data.month;
        break;
      }
    }

    for (Rilevazione elem in widget.storico) {
      if (elem.data.month != currentMonth &&
          elem.data.month != secondMonth) {
        thirdMonth = elem.data.month;
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
                                  color: widget.colorPollutant,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold)),
                          Row(
                            children: [
                              Text(widget.valoreAttuale,
                                  style: TextStyle(
                                    fontSize: 40,
                                  )),
                              Text.rich(
                                TextSpan(
                                  text: widget.valoreAttuale == valoreNonRilevato ? "" : widget.soglia,
                                  style: TextStyle(fontSize: 25),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: widget.valoreAttuale == valoreNonRilevato ? "" :widget.unitaMisura,
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
                                  color: widget.colorPollutant,
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
                            progressColor: widget.colorPollutant,
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
                            progressColor: widget.colorPollutant,
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
                            progressColor: widget.colorPollutant,
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
                  storico: widget.storico.reversed.toList(),
                  colorPollutant: widget.colorPollutant,
                )),
            MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: null == widget.storico ? 0 : widget.storico.length,
                  itemBuilder: (context, index) {
                    Rilevazione elem = widget.storico[index];
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
                                    TextSpan(text: '${widget.soglia}${widget.unitaMisura}',
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
    );

  }
}
