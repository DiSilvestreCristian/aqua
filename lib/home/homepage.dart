import 'package:aqua/beach_details/beach_details.dart';
import 'package:aqua/instance_spiagge.dart';
import 'package:aqua/model/spiagge_ridotto.dart';
import 'package:aqua/value/colors.dart';
import 'package:aqua/value/marker_visible.dart';
import 'package:aqua/value/numbers.dart';
import 'package:aqua/value/strings.dart';
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
  late double iconMarker;
/*late BitmapDescriptor iconMarkerGreen;
  late BitmapDescriptor iconMarkerYellow;
  late BitmapDescriptor iconMarkerOrange;
  late BitmapDescriptor iconMarkerRed;
  late BitmapDescriptor iconMarkerGrey;


  Future<void> setCustomMarker() async {
    iconMarkerGreen = await BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'images/marker_verde.png');
    iconMarkerYellow = await BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'images/marker_giallo');
    iconMarkerOrange = await BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'images/marker_arancione');
    iconMarkerRed = await BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'images/marker_rosso');
    iconMarkerGrey = await BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'images/marker_grigio');
  }*/


  static const _initialcameraPosition = CameraPosition(
    target : LatLng(initialMapLat, initialMapLng),
    zoom : initialMapZoom,
  );

  late FloatingSearchBarController controller;
  late GoogleMapController googleMapController;

  @override
  void dispose() {
    googleMapController.dispose();
    controller.dispose();
    super.dispose();
  }

  late LatLng userCurrentPosition;
  void _getUserLocation() async {
    var position = await GeolocatorPlatform.instance
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      userCurrentPosition = LatLng(position.latitude, position.longitude);
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
    _currentZoom = initialMapZoom;
    //setCustomMarker();
    _getUserLocation();
    controller = FloatingSearchBarController();
    _filteredSearchResults = filterSearchTerms(filter: "");
    getSingleton().then((spiaggeRidotto) {
      bool visibility = false;
      setState(() {
        _spiagge = spiaggeRidotto;

        for (SpiaggiaRidotto elem in spiaggeRidotto){
          visibility = false;
          if (firstLevelMarker.contains(elem.id)) {
            visibility = true;
          }
            setMarker(elem, visibility);
        }

      });
    });
  }

  setMarker(SpiaggiaRidotto spiaggia, bool visibility){
    setState(() {
      String _quality = spiaggia.qualita;
      iconMarker = BitmapDescriptor.hueGreen ;
      if (_quality == qualityGood)
        iconMarker = BitmapDescriptor.hueYellow;
      else if (_quality == qualitySufficient)
        iconMarker = BitmapDescriptor.hueOrange;
      else if (_quality == qualityBad)
        iconMarker = BitmapDescriptor.hueRed;
      else if (_quality == qualityNotClassified)
        iconMarker = BitmapDescriptor.hueAzure;
      _markers.add(
        Marker(
            markerId: MarkerId(spiaggia.id),
            visible: visibility,
            position: LatLng(spiaggia.coordinate.x, spiaggia.coordinate.y),
            infoWindow: InfoWindow(
              title: spiaggia.comune,
              snippet: spiaggia.descrizione,
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                      pageBuilder: (_, __, ___) =>
                          BeachDetails(spiaggia: spiaggia)),
                );
              },
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(iconMarker),
            onTap: () {
              googleMapController.animateCamera(
                  CameraUpdate.newCameraPosition(CameraPosition(
                    target: LatLng(spiaggia.coordinate.x, spiaggia.coordinate.y),
                    zoom: markerSelectedMapZoom,
                    tilt: markerSelectedMapTilt,
                  )));
            }),
      );
    });
  }

  updateMarkers(){

    if (_currentZoom<secondLevelZoom){
      setState(() {
        _markers.clear();
      });
      bool visibility = false;
      setState(() {
        for (SpiaggiaRidotto elem in _spiagge){
          visibility = false;
          if (firstLevelMarker.contains(elem.id)) {
            visibility = true;
          }
          setMarker(elem, visibility);
        }
      });
    }

    if (_currentZoom>=secondLevelZoom && _currentZoom<thirdLevelZoom){
      setState(() {
        _markers.clear();
      });
      bool visibility = false;
      setState(() {
        for (SpiaggiaRidotto elem in _spiagge){
          visibility = false;
          if (firstLevelMarker.contains(elem.id) || secondLevelMarker.contains(elem.id)) {
            visibility = true;
          }
          setMarker(elem, visibility);
        }
      });
    }

    if (_currentZoom>=thirdLevelZoom){
      setState(() {
        _markers.clear();
      });
      bool visibility = true;
      setState(() {
        for (SpiaggiaRidotto elem in _spiagge){
          setMarker(elem, visibility);
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
            updateMarkers()
            ),
          ),
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton (
                backgroundColor: colorItemBackgroundSecondary,
                foregroundColor: colorPrimary,
                onPressed: ()=> googleMapController.animateCamera(
                  CameraUpdate.newCameraPosition( CameraPosition(
                    target: userCurrentPosition,
                    zoom: initialMapZoom,
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
      hint: searchBarHint,
      elevation: 0,
      backdropColor: colorItemBackgroundTertiary,
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
            color: colorTextSecondary,
            elevation: 4,
            child: Builder(
              builder: (context){
                if (_filteredSearchResults.isEmpty && controller.query.isEmpty) {
                  return Container (
                    height: 56,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text (
                      searchBarIniziaRicerca,
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
                      searchBarNessunRisultato,
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