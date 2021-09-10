import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Set<Marker> _markers = {};

  @override
  void initState(){
    super.initState();

      setState(() {
        _markers.add(
            Marker(
              //pesaro
              markerId: MarkerId('IT011041044024'),
              position: LatLng(43.914491, 12.9214),
              infoWindow: InfoWindow(
                title: "Pesaro",
                snippet: "(luogo?)"
              )
            ),
        );
        _markers.add(
          Marker(
            //ancona
              markerId: MarkerId('IT011042002006'),
              position: LatLng(43.616667, 13.535278),
              infoWindow: InfoWindow(
                  title: "Ancona",
                  snippet: "(luogo?)"
              )
          ),
        );
        _markers.add(
          Marker(
            //grottammare
              markerId: MarkerId('IT011044023002'),
              position: LatLng(42.995629, 13.871395),
              infoWindow: InfoWindow(
                  title: "Grottammare",
                  snippet: "(luogo?)"
              )
          ),
        );
        _markers.add(
          Marker(
            //portonovo
              markerId: MarkerId('IT011042002013'),
              position: LatLng(43.566700, 13.591700),
              infoWindow: InfoWindow(
                  title: "Portonovo",
                  snippet: "(luogo?)"
              )
          ),
        );
        _markers.add(
          Marker(
            //pedaso
              markerId: MarkerId('IT011109030001'),
              position: LatLng(43.087967, 13.846817),
              infoWindow: InfoWindow(
                  title: "Pedaso",
                  snippet: "(luogo?)"
              )
          ),
        );
        _markers.add(
          Marker(
            //porto recanati
              markerId: MarkerId('IT011043042012'),
              position: LatLng(43.440278, 13.661667),
              infoWindow: InfoWindow(
                  title: "Porto Recanati",
                  snippet: "(luogo?)"
              )
          ),
        );
        _markers.add(
          Marker(
            //sirolo
              markerId: MarkerId('IT011042048005'),
              position: LatLng(43.524167, 13.624722),
              infoWindow: InfoWindow(
                  title: "Sirolo",
                  snippet: "(luogo?)"
              )
          ),
        );
      });
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

