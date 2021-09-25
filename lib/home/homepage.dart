import 'package:aqua/beach_details/beach_details.dart';
import 'package:aqua/fetch_parse_JSON/sercices_ridotto.dart';
import 'package:aqua/fetch_parse_JSON/spiagge_ridotto.dart';
import 'package:aqua/value/colors.dart';
import 'package:aqua/value/strings.dart';
import 'package:flutter/material.dart';
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
          .where((term) => term.name.toLowerCase().startsWith(filter)).toList();
    } else {
      return [];
    }
  }

  Set<Marker> _markers = {};
  late BitmapDescriptor iconMarker;

  Future<void> setCustomMarker(String quality) async {
    iconMarker = await BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'images/marker_verde');
    if (quality == "Buona")
      iconMarker = await BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'images/marker_giallo');
    else if (quality == "Sufficiente")
      iconMarker = await BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'images/marker_arancione');
    else if (quality == "Scarsa")
      iconMarker = await BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'images/marker_rosso');
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

  @override
  void initState() {
    super.initState();
    controller = FloatingSearchBarController();
    _filteredSearchResults = filterSearchTerms(filter: "");
    ServicesRidotto.getSpiaggeRidotto().then((spiaggeRidotto) {
      String _quality ="";
      setState(() {
        _spiagge = spiaggeRidotto;
        for (SpiaggiaRidotto elem in spiaggeRidotto){
          setCustomMarker(elem.quality);
          _markers.add(
            Marker(
                markerId: MarkerId(elem.id),
                position: LatLng(elem.coordinates.x, elem.coordinates.y),
                infoWindow: InfoWindow(
                  title: elem.name,
                  snippet: "$infoBoxMarker $_quality",
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(pageBuilder: (_, __, ___) => BeachDetails(spiaggia: elem)),
                    );
                  },
                ),
                icon: iconMarker,
                onTap: () {
                  googleMapController.animateCamera(
                      CameraUpdate.newCameraPosition(
                          CameraPosition(
                            target: LatLng(
                                elem.coordinates.x, elem.coordinates.y),
                            zoom: 12.0,
                            tilt: 50.0,
                          )
                      )
                  );
                }
            ),
          );
        }
      });
    });
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
          ),
          floatingActionButton: FloatingActionButton (
            backgroundColor: colorItemBackgroundSecondary,
            foregroundColor: colorPrimary,
            onPressed: () => googleMapController.animateCamera(
              CameraUpdate.newCameraPosition(_initialcameraPosition),
            ),
            child: Icon (Icons.center_focus_strong),
          )
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
                          term.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                      ),
                      leading: const Icon(Icons.place),
                      onTap: (){
                        controller.close();
                        googleMapController.animateCamera(
                            CameraUpdate.newCameraPosition(
                                CameraPosition(
                                  target: LatLng(term.coordinates.x, term.coordinates.y),
                                  zoom: 12.0,
                                  tilt: 50.0,
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