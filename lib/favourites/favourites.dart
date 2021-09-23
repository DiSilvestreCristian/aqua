import 'package:aqua/fetch_parse_JSON/sercices_ridotto.dart';
import 'package:aqua/fetch_parse_JSON/spiagge_ridotto.dart';
import 'package:aqua/value/strings.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Favourites extends StatefulWidget {
  const Favourites({Key? key}) : super(key: key);

  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites>{

  List<SpiaggiaRidotto> _spiagge = [];
  List<SpiaggiaRidotto> listFav = [];

  List<SpiaggiaRidotto> createListFav () {
    int x = 0;
    List<SpiaggiaRidotto> list = [];
    for (SpiaggiaRidotto spiaggia in _spiagge){
      x = _getFavValue(spiaggia.id) as int;
      if (x == 1) {
        x = 0;
        list.add(spiaggia);
      }
    }
    return list;
  }

  Future<int> _getFavValue (String id) async{
    final prefs = await SharedPreferences.getInstance();

    return (prefs.getInt(id) ?? 0);
  }

  @override
  void initState() {
    super.initState();
    ServicesRidotto.getSpiaggeRidotto().then((spiagge){
      for (SpiaggiaRidotto spiaggia in spiagge){
        if (_getFavValue(spiaggia.id) == 1)
          listFav.add(spiaggia);
      }
      setState(() {
        _spiagge = spiagge;
      });
    });
  }

  int _current = 0;

  Widget build(BuildContext context){
    return Scaffold(
      body: CarouselSlider(
        options: CarouselOptions(
          initialPage: 0,
          scrollDirection: Axis.horizontal,
          onPageChanged: (index, _){
            setState(() {
              _current = index;
            });
          }
        ),
        items: listFav.map((item) {
          return Builder(
              builder: (BuildContext contex){
                return Container(
                  child: Center(
                    child: Text(item.name),
                  ),
                );
              }
          );
        }).toList(),
      ),
    );
  }
}
