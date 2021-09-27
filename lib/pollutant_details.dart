import 'package:flutter/material.dart';

import 'fetch_parse_JSON/services_storico.dart';
import 'fetch_parse_JSON/spiagge_ridotto.dart';
import 'fetch_parse_JSON/storico.dart';

class PollutantDetails extends StatefulWidget {

  final SpiaggiaRidotto spiaggia;
  final String inquinante;

  const PollutantDetails({
    Key? key,
    required this.spiaggia,
    required this.inquinante
  }) : super(key: key);

  @override
  _PollutantDetailsState createState() => _PollutantDetailsState();
}

class _PollutantDetailsState extends State<PollutantDetails> {

  List<Rilevazione> _storico = [];

  @override
  void initState() {
    super.initState();
    ServicesStorico.getStorico().then((storico){
      setState(() {
        _storico = storico;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(_storico[0].data.toString()),
      ),
    );
  }
}
