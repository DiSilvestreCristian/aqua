import 'package:aqua/fetch_parse_JSON/services_ridotto.dart';
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

  late List<SpiaggiaRidotto> _spiagge;
  Set<Marker> _markers = {};
  late String nome;
  @override
  void initState() {
    super.initState();
      ServicesRidotto.getSpiaggeRidotto().then((spiaggeRidotto){
        String _quality ="";
        setState(() {
        _spiagge = spiaggeRidotto;
        for (SpiaggiaRidotto elem in spiaggeRidotto){
          _quality = elem.quality;
          _markers.add(
            Marker(
                markerId: MarkerId(elem.id),
                position: LatLng(elem.coordinates.x, elem.coordinates.y),
                infoWindow: InfoWindow(
                    title: elem.name,
                    snippet: "$infoBoxMarker $_quality"
                )
            ),
          );
        }

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
        markers: _markers,
        initialCameraPosition: CameraPosition(
            target: LatLng(43.5, 13.3),
            zoom: 8.7,
        )
    );
  }
}

