import 'package:aqua/fetch_parse_JSON/services_ridotto.dart';
import 'package:aqua/fetch_parse_JSON/spiagge_ridotto.dart';
import 'package:aqua/value/colors.dart';
import 'package:aqua/value/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late List<SpiaggiaRidotto> _spiagge;

  Set<Marker> _markers = {};
  static const _initialcameraPosition = CameraPosition(
  target : LatLng(43.5, 13.3),
  zoom : 8.7,
  );

  late GoogleMapController _googleMapController;

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
      ServicesRidotto.getSpiaggeRidotto().then((spiaggeRidotto){
        String _quality ="";
        setState(() {
        _spiagge = spiaggeRidotto;
        for (SpiaggiaRidotto elem in spiaggeRidotto){
          _quality = elem.quality;
          double color = BitmapDescriptor.hueGreen;
          if (_quality == "Buona") color = BitmapDescriptor.hueYellow;
          else if (_quality == "Sufficiente") color = BitmapDescriptor.hueOrange;
          else if (_quality == "Scarsa") color = BitmapDescriptor.hueRed;
          _markers.add(
            Marker(
                markerId: MarkerId(elem.id),
                position: LatLng(elem.coordinates.x, elem.coordinates.y),
                infoWindow: InfoWindow(
                    title: elem.name,
                    snippet: "$infoBoxMarker $_quality"
                ),
                icon:
                BitmapDescriptor.defaultMarkerWithHue(color),
                onTap: () => _googleMapController.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: LatLng(elem.coordinates.x, elem.coordinates.y),
                      zoom: 12.0,
                      tilt: 50.0,

                    )
                  )
                )
            ),
          );
        }

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
          markers: _markers,
            zoomControlsEnabled: false,
            myLocationButtonEnabled: false,
            initialCameraPosition: _initialcameraPosition,
          onMapCreated: (controller) => _googleMapController = controller,
        ),
        floatingActionButton: FloatingActionButton (
          backgroundColor: colorItemBackgroundSecondary,
          foregroundColor: colorPrimary,
          onPressed: () => _googleMapController.animateCamera(
              CameraUpdate.newCameraPosition(_initialcameraPosition),
          ),
          child: Icon (Icons.center_focus_strong),
        )
    );
  }
}

