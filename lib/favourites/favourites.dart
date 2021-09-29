import 'package:aqua/beach_details/beach_details.dart';
import 'package:aqua/instance_spiagge.dart';
import 'package:aqua/services/sercices_ridotto.dart';
import 'package:aqua/model/spiagge_ridotto.dart';
import 'package:aqua/value/colors.dart';
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
  List<SpiaggiaRidotto> list = [];

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
    var value = (prefs.getInt(id) ?? 0);
    return value;
  }

  Future<List<SpiaggiaRidotto>> getSingleton(){
    var singleton = new SingletonSpiagge();
    final spiagge = singleton.spiagge;
    return spiagge;
  }

  @override
  void initState(){
    List<SpiaggiaRidotto> listFav= [];
    super.initState();
    getSingleton().then((spiagge){
      spiagge.forEach((spiaggia){
        //var x = spiaggia.id;
        //var t = spiaggia.name;
        _getFavValue(spiaggia.id).then((value){
          if (value == 1) {
            var y = value;
            listFav.add(spiaggia);
          }
        });
      });
      setState(() {
        list = listFav;
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
          items: list.map((item) {
            return Builder(
                builder: (BuildContext contex){
                  return BeachDetails(spiaggia: item);
                }
            );
          }).toList(),
        ),
    );
  }
}
