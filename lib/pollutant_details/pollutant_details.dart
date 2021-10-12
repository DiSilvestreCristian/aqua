import 'package:aqua/model/storico.dart';
import 'package:aqua/pollutant_details/storico.dart';
import 'package:aqua/pollutant_details/storico_vuoto.dart';
import 'package:aqua/value/colors.dart';
import 'package:flutter/material.dart';
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
  List<Rilevazione> _storicoIntero = [];

  late AssetImage iconPollutant;
  late TextSpan namePollutant;
  late Color colorPollutant;

  late String soglia, unitaMisura, valoreAttuale;

  @override
  void initState() {
    super.initState();

    switch (widget.inquinante) {
      case ostreopsisName:
        {
          valoreAttuale = widget.spiaggia.ostreopsis == null? valoreNonRilevato : widget.spiaggia.ostreopsis.toString();
          iconPollutant = AssetImage('images/icon_ostreopsis.png');
          namePollutant = ostreopsisLabel;
          colorPollutant = colorOstreopsis;
          soglia = sogliaOstreopsis;
          unitaMisura = unitaOstreopsis;
          break;
        }
      case escherichiaName:
        {
          valoreAttuale = widget.spiaggia.escherichia == null? valoreNonRilevato : widget.spiaggia.escherichia.toString();
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
          valoreAttuale = widget.spiaggia.enterococcus == null? valoreNonRilevato : widget.spiaggia.enterococcus.toString();
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

    ServicesStorico.getStorico(widget.inquinante, widget.spiaggia.id).then((storico) {
      setState(() {
        _storicoIntero = new List<Rilevazione>.from(storico);
        _storicoIntero.removeWhere((element) => element.value == null);
        _storicoIntero.sort((a, b) => b.data.compareTo(a.data));
        _storico = new List<Rilevazione>.from(_storicoIntero);
        int index = 0;
        _storicoIntero.forEach((element) {
          if (index>=12){
            _storico.remove(element);
          }
          index++;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorItemBackgroundSecondary,
        body: Padding(
            padding: EdgeInsets.only(top: 50.0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.spiaggia.comune,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                              ),
                              Text(
                                widget.spiaggia.descrizione,
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5,),
                        Row(
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
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  if(_storico.isNotEmpty)
                    Storico(
                      valoreAttuale: valoreAttuale,
                      storico: _storico,
                      inquinante: widget.inquinante,
                      soglia: soglia,
                      unitaMisura: unitaMisura,
                      colorPollutant: colorPollutant,
                    )
                  else if (widget.spiaggia.stazioneVicina == null) 
                    StoricoVuoto(testo: noOstreopsis)
                  else StoricoVuoto(testo: storicoVuoto)
            ])));
  }
}
