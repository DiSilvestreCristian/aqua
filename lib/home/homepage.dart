import 'package:aqua/fetch_parse_JSON/services.dart';
import 'package:aqua/fetch_parse_JSON/services_ridotto.dart';
import 'package:aqua/fetch_parse_JSON/spiaggia.dart';
import 'package:aqua/fetch_parse_JSON/spiagge_ridotto.dart';
import 'package:aqua/value/strings.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late List<Spiaggia> _spiagge;
  Set<Marker> _markers = {};
  late String nome;
  @override
  void initState() {
    super.initState();
      ServicesRidotto.getSpiaggeRidotto().then((spiaggeRidotto){
        setState(() {

        //_spiagge = spiagge;
        nome = spiaggeRidotto[0].id;
        //for (SpiaggiaRidotto elem in _spiagge){
          _markers.add(
            Marker(
                markerId: MarkerId(nome),
                position: LatLng(43.5, 13.4),
                infoWindow: InfoWindow(
                    title: "ciao",
                    snippet: "hello"
                )
            ),
          );
        //}

      });
    });
  }

  String getQuality (int value){
    String quality;
    switch(value as String){
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

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
        markers: _markers,
        initialCameraPosition: CameraPosition(
            target: LatLng(43.5, 13.4),
            zoom: 9,
        )
    );
  }
}

