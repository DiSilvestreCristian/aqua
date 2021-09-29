import 'package:aqua/fetch_parse_JSON/storico.dart';
import 'package:aqua/value/strings.dart';
import 'package:flutter/material.dart';

import 'chart_painter.dart';

class GraficoStorico extends StatefulWidget {
  final List<Rilevazione> storico;
  final Color colorPollutant;

  const GraficoStorico({
    Key? key,
    required this.storico,
    required this.colorPollutant
  }) : super(key: key);

  @override
  _GraficoStoricoState createState() => _GraficoStoricoState();
}

class _GraficoStoricoState extends State<GraficoStorico> {

  late double _min, _max;
  late List<double> _Y;
  late List<String> _X;

  @override
  void initState() {
    super.initState();
    var min = double.maxFinite;
    var max = -double.maxFinite;
    widget.storico.forEach((element) {
      min = min > element.value? element.value.toDouble() : min;
      max = max < element.value? element.value.toDouble() : max;
    });

    setState(() {
      _min = min;
      _max = max;
      _Y = widget.storico.map((p) => p.value.toDouble()).toList();
      _X = widget.storico.map((p) => "${p.data.day}\n${mesiIniziali[p.data.month]}").toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        child: Container(),
        painter: ChartPainter(_X, _Y, _min, _max, widget.colorPollutant),
      )
    );
  }
}

