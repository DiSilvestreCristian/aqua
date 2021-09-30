import 'package:aqua/beach_details/beach_details.dart';
import 'package:aqua/instance_spiagge.dart';
import 'package:aqua/model/spiagge_ridotto.dart';
import 'package:aqua/value/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'add_favourites.dart';

class Favourites extends StatefulWidget {
  const Favourites({Key? key}) : super(key: key);

  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites>{
  List<SpiaggiaRidotto> listFav= [];
  List<SpiaggiaRidotto> _spiagge = [];

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

  List<SpiaggiaRidotto> updateList (){
    List<SpiaggiaRidotto> list =[];
    _spiagge.forEach((spiaggia) {
      _getFavValue(spiaggia.id).then((value){
        if (value == 1) {
          setState(() {
            list.add(spiaggia);
          });
        }
      });
    });
    return list;
  }

  @override
  void initState(){
    super.initState();
    getSingleton().then((spiagge){
      setState(() {
        _spiagge = spiagge;
      });
      setState(() {
        listFav = updateList();
      });
    });
  }

  int _current = 0;
  @override
  Widget build(BuildContext context){
    WidgetsBinding.instance!.addPostFrameCallback((_) =>
        setState(() {
          listFav = updateList();
    }));
    if (listFav.length == 0) return AddFavourites();
    return Scaffold(
      body: Column(
        children: [
          CarouselSlider(
                options: CarouselOptions(
                    viewportFraction: 1,
                    height: MediaQuery.of(context).size.height - 120.0,
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
                      builder: (BuildContext contex) {
                        return BeachDetails(spiaggia: item);
                      });
                }).toList(),
              ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: listFav.map((fav) {
              int index = listFav.indexOf(fav);
              return Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index
                      ? colorPrimary
                      : colorSecondary,
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}
