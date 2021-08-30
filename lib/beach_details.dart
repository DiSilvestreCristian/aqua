import 'package:aqua/spiaggia.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

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
                      Icon(Icons.place,
                        size: 45,
                        color: Colors.blue[600],
                      ),
                    ],
                  ),
                ),
                CircularPercentIndicator(
                  radius: 250,
                  lineWidth: 25,
                  percent: getPercentage(spiaggia.ostreopsis[0].value, "ostreopsis"),
                  progressColor: Colors.green[700],
                  circularStrokeCap: CircularStrokeCap.round,
                  center: CircularPercentIndicator(
                    radius: 180,
                    lineWidth: 25,
                    percent: getPercentage(spiaggia.escherichia[0].value, "escherichia"),
                    progressColor: Colors.blue[700],
                    circularStrokeCap: CircularStrokeCap.round,
                    center:
                    CircularPercentIndicator(
                      radius: 110,
                      lineWidth: 25,
                      percent: getPercentage(spiaggia.enterococcus[0].value, "enterococcus"),
                      progressColor: Colors.red[700],
                      circularStrokeCap: CircularStrokeCap.round,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 6.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.star_border,
                      size: 45,
                      color: Colors.blue[600],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

double getPercentage(int val, String pollutant){
  int tolerance_level;
  switch(pollutant){
    case "ostreopsis": tolerance_level = 30000;
    break;
    case "escherichia": tolerance_level = 500;
    break;
    case "enterococcus": tolerance_level = 200;
    break;
    default: tolerance_level = 30000;
  }
  return (val/tolerance_level);
}

