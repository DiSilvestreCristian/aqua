import 'package:aqua/beach_details/beach_details.dart';
import 'package:aqua/instance_spiagge.dart';
import 'package:aqua/model/spiagge_ridotto.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Favourites extends StatefulWidget {
  const Favourites({Key? key}) : super(key: key);

  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites>{
  List<SpiaggiaRidotto> listFav= [];
  List<SpiaggiaRidotto> _spiagge = [];
  int _value = 0;
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
    super.initState();
    getSingleton().then((spiagge){
      setState(() {
        _spiagge = spiagge;
      });
      spiagge.forEach((spiaggia) {
        _getFavValue(spiaggia.id).then((value){
          if (value == 1) {
            setState(() {
              listFav.add(spiaggia);
            });
          }
        });
      });
    });
  }

  int _current = 0;
  @override
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
                  return Center(child: Text("${item.name}"));
                }
            );
          }).toList(),
        ),
    );
  }
}
