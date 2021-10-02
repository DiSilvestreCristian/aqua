import 'package:aqua/beach_details/beach_details.dart';
import 'package:aqua/instance_spiagge.dart';
import 'package:aqua/model/spiagge_ridotto.dart';
import 'package:aqua/value/colors.dart';
import 'package:aqua/value/marker_visible.dart';
import 'package:aqua/value/numbers.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class HomaPage extends StatefulWidget {
  const HomaPage({Key? key}) : super(key: key);

  @override
  _HomaPageState createState() => _HomaPageState();
}

class _HomaPageState extends State<HomaPage> {

  List<SpiaggiaRidotto> _spiagge = [];
  List<SpiaggiaRidotto> _filteredSearchResults = [];

  late SpiaggiaRidotto selectedTerm;

  List<SpiaggiaRidotto> filterSearchTerms({
    required String filter,
    }){
    if (filter != "" && filter.isNotEmpty){
      return _spiagge
          .where((term) => (term.comune.toLowerCase().startsWith(filter.toLowerCase())) ||
          (term.descrizione.toLowerCase().contains(filter.toLowerCase()))).toList();
    } else {
      return [];
    }
  }

  late double _currentZoom;

  Set<Marker> _markers = {};
  late BitmapDescriptor iconMarker;
  late BitmapDescriptor iconMarkerGreen;
  late BitmapDescriptor iconMarkerYellow;
  late BitmapDescriptor iconMarkerOrange;
  late BitmapDescriptor iconMarkerRed;


  Future<void> setCustomMarker() async {
    iconMarkerGreen = await BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'images/marker_verde.png');
    iconMarkerYellow = await BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'images/marker_giallo');
    iconMarkerOrange = await BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'images/marker_arancione');
    iconMarkerRed = await BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'images/marker_rosso');
  }


  static const _initialcameraPosition = CameraPosition(
    target : LatLng(43.5, 13.3),
    zoom : 8.7,
  );

  late FloatingSearchBarController controller;
  late GoogleMapController googleMapController;

  @override
  void dispose() {
    googleMapController.dispose();
    controller.dispose();
    super.dispose();
  }

  late LatLng currentPosition;
  void _getUserLocation() async {
    var position = await GeolocatorPlatform.instance
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      currentPosition = LatLng(position.latitude, position.longitude);
    });
  }

  Future<List<SpiaggiaRidotto>> getSingleton(){
    var singleton = new SingletonSpiagge();
    final spiagge = singleton.spiagge;
    return spiagge;
  }



  @override
  void initState() {
    super.initState();
    _currentZoom = 8.7;
    setCustomMarker();
    _getUserLocation();
    controller = FloatingSearchBarController();
    _filteredSearchResults = filterSearchTerms(filter: "");
    getSingleton().then((spiaggeRidotto) {
      String _quality ="";
      bool visibility = false;
      setState(() {
        _spiagge = spiaggeRidotto;
        for (SpiaggiaRidotto elem in spiaggeRidotto){
          visibility = false;
          if (firstLevelMarker.contains(elem.id)) {
            visibility = true;
          }
            _quality = elem.qualita;
            iconMarker = iconMarkerGreen;
            if (_quality == "BUONA")
              iconMarker = iconMarkerYellow;
            else if (_quality == "SUFFICIENTE")
              iconMarker = iconMarkerOrange;
            else if (_quality == "SCARSA")
              iconMarker = iconMarkerRed;
            else if (_quality == "NON CLASSIFICATA")
              iconMarker = iconMarkerRed;
            _markers.add(
              Marker(
                  markerId: MarkerId(elem.id),
                  visible: visibility,
                  position: LatLng(elem.coordinate.x, elem.coordinate.y),
                  infoWindow: InfoWindow(
                    title: elem.comune,
                    snippet: elem.descrizione,
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                            pageBuilder: (_, __, ___) =>
                                BeachDetails(spiaggia: elem)),
                      );
                    },
                  ),
                  icon: iconMarker,
                  //BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
                  onTap: () {
                    googleMapController.animateCamera(
                        CameraUpdate.newCameraPosition(CameraPosition(
                      target: LatLng(elem.coordinate.x, elem.coordinate.y),
                          zoom: markerSelectedMapZoom,
                          tilt: markerSelectedMapTilt,
                    )));
                  }),
            );

        }
      });
    });
  }

  updateMarker(){

    if (_currentZoom<secondLevelZoom){
      setState(() {
        _markers.clear();
      });
      String _quality ="";
      bool visibility = false;
      setState(() {
        for (SpiaggiaRidotto elem in _spiagge){
          visibility = false;
          if (firstLevelMarker.contains(elem.id)) {
            visibility = true;
          }
          _quality = elem.qualita;
          iconMarker = iconMarkerGreen;
          if (_quality == "BUONA")
            iconMarker = iconMarkerYellow;
          else if (_quality == "SUFFICIENTE")
            iconMarker = iconMarkerOrange;
          else if (_quality == "SCARSA")
            iconMarker = iconMarkerRed;
          else if (_quality == "NON CLASSIFICATA")
            iconMarker = iconMarkerRed;
          _markers.add(
            Marker(
                markerId: MarkerId(elem.id),
                visible: visibility,
                position: LatLng(elem.coordinate.x, elem.coordinate.y),
                infoWindow: InfoWindow(
                  title: elem.comune,
                  snippet: elem.descrizione,
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (_, __, ___) =>
                              BeachDetails(spiaggia: elem)),
                    );
                  },
                ),
                icon: iconMarker,
                //BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
                onTap: () {
                  googleMapController.animateCamera(
                      CameraUpdate.newCameraPosition(CameraPosition(
                        target: LatLng(elem.coordinate.x, elem.coordinate.y),
                        zoom: markerSelectedMapZoom,
                        tilt: markerSelectedMapTilt,
                      )));
                }),
          );
        }
      });
    }

    if (_currentZoom>=secondLevelZoom && _currentZoom<thirdLevelZoom){
      setState(() {
        _markers.clear();
      });
      String _quality ="";
      bool visibility = false;
      setState(() {
        for (SpiaggiaRidotto elem in _spiagge){
          visibility = false;
          if (firstLevelMarker.contains(elem.id) || secondLevelMarker.contains(elem.id)) {
            visibility = true;
          }
            _quality = elem.qualita;
            iconMarker = iconMarkerGreen;
            if (_quality == "BUONA")
              iconMarker = iconMarkerYellow;
            else if (_quality == "SUFFICIENTE")
              iconMarker = iconMarkerOrange;
            else if (_quality == "SCARSA")
              iconMarker = iconMarkerRed;
            else if (_quality == "NON CLASSIFICATA")
              iconMarker = iconMarkerRed;
            _markers.add(
              Marker(
                  markerId: MarkerId(elem.id),
                  visible: visibility,
                  position: LatLng(elem.coordinate.x, elem.coordinate.y),
                  infoWindow: InfoWindow(
                    title: elem.comune,
                    snippet: elem.descrizione,
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                            pageBuilder: (_, __, ___) =>
                                BeachDetails(spiaggia: elem)),
                      );
                    },
                  ),
                  icon: iconMarker,
                  //BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
                  onTap: () {
                    googleMapController.animateCamera(
                        CameraUpdate.newCameraPosition(CameraPosition(
                          target: LatLng(elem.coordinate.x, elem.coordinate.y),
                          zoom: markerSelectedMapZoom,
                          tilt: markerSelectedMapTilt,
                        )));
                  }),
            );
        }
      });
    }

    if (_currentZoom>=thirdLevelZoom){
      setState(() {
        _markers.clear();
      });
      String _quality ="";
      bool visibility = true;
      setState(() {
        for (SpiaggiaRidotto elem in _spiagge){
          _quality = elem.qualita;
          iconMarker = iconMarkerGreen;
          if (_quality == "BUONA")
            iconMarker = iconMarkerYellow;
          else if (_quality == "SUFFICIENTE")
            iconMarker = iconMarkerOrange;
          else if (_quality == "SCARSA")
            iconMarker = iconMarkerRed;
          else if (_quality == "NON CLASSIFICATA")
            iconMarker = iconMarkerRed;
          _markers.add(
            Marker(
                markerId: MarkerId(elem.id),
                visible: visibility,
                position: LatLng(elem.coordinate.x, elem.coordinate.y),
                infoWindow: InfoWindow(
                  title: elem.comune,
                  snippet: elem.descrizione,
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (_, __, ___) =>
                              BeachDetails(spiaggia: elem)),
                    );
                  },
                ),
                icon: iconMarker,
                //BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
                onTap: () {
                  googleMapController.animateCamera(
                      CameraUpdate.newCameraPosition(CameraPosition(
                        target: LatLng(elem.coordinate.x, elem.coordinate.y),
                        zoom: markerSelectedMapZoom,
                        tilt: markerSelectedMapTilt,
                      )));
                }),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FloatingSearchBar(
      body: Scaffold(
          body: GoogleMap(
            markers: _markers,
            zoomControlsEnabled: false,
            myLocationButtonEnabled: false,
            initialCameraPosition: _initialcameraPosition,
            onMapCreated: (controller) => googleMapController = controller,
            onCameraMove: (position) {
              setState(() {
                _currentZoom = position.zoom;
              });
            },
            onCameraIdle: (
            updateMarker()
            ),
          ),
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton (
                backgroundColor: colorItemBackgroundSecondary,
                foregroundColor: colorPrimary,
                onPressed: () => googleMapController.animateCamera(
                  CameraUpdate.newCameraPosition( CameraPosition(
                    target: currentPosition,
                    zoom: 8.7,
                  )
                  ),
                ),
                child: Icon (Icons.location_on),
              ),
              SizedBox(height: 15.0,),
              FloatingActionButton (
                backgroundColor: colorItemBackgroundSecondary,
                foregroundColor: colorPrimary,
                onPressed: () => googleMapController.animateCamera(
                  CameraUpdate.newCameraPosition(_initialcameraPosition),
                ),
                child: Icon (Icons.center_focus_strong),
              ),
            ],
          ),
      ),
      controller: controller,
      transition: CircularFloatingSearchBarTransition(),
      physics: BouncingScrollPhysics(),
      hint: 'Cerca...',
      elevation: 0,
      backdropColor: Color(0x00FFFFFF),
      borderRadius: BorderRadius.circular(30.0),
      margins: const EdgeInsets.only(top: 68.0, left: 45.0, right: 10.0),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      clearQueryOnClose: true,
      onQueryChanged: (query){
        setState(() {
          _filteredSearchResults = filterSearchTerms(filter: query);
        });
      },
      onSubmitted: (query) {},
      builder: (context, transition){
        return ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Material(
            color: Colors.white,
            elevation: 4,
            child: Builder(
              builder: (context){
                if (_filteredSearchResults.isEmpty && controller.query.isEmpty) {
                  return Container (
                    height: 56,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text (
                      'Inizia la ricerca',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.caption,
                    ),
                  );
                } else if (_filteredSearchResults.isEmpty) {
                  return Container (
                    height: 56,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text (
                      'Spiaggia non trovata',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.caption,
                    ),
                  );
                } else {
                  return Column (
                    mainAxisSize: MainAxisSize.min,
                    children: _filteredSearchResults.map((term) => ListTile(
                      title: Text(
                          term.comune,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        term.descrizione,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      leading: const Icon(Icons.place),
                      onTap: (){
                        controller.close();
                        googleMapController.animateCamera(
                            CameraUpdate.newCameraPosition(
                                CameraPosition(
                                  target: LatLng(term.coordinate.x, term.coordinate.y),
                                  zoom: markerSelectedMapZoom,
                                  tilt: markerSelectedMapTilt,
                                )
                            )
                        );
                      }
                    )).toList(),
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }
}