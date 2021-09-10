import 'package:aqua/fetch_parse_JSON/services.dart';
import 'package:aqua/spiagge_ridotto.dart';
import 'package:aqua/value/strings.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Set<Marker> _markers = {};


  late List<SpiaggiaRidotto> _spiaggeRidotto;

  @override
  void initState() {
    super.initState();
    setState(() {
      Services.getSpiaggeRidotto().then((spiagge){
        _spiaggeRidotto = spiagge;
        for (SpiaggiaRidotto elem in spiagge){
          _markers.add(
            Marker(
              markerId: MarkerId(elem.id),
              position: LatLng(elem.coordinates.x, elem.coordinates.y),
              infoWindow: InfoWindow(
                  title: elem.name,
                  snippet: getQuality(elem.quality)
              )
            ),
          );
        }
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

