import 'package:aqua/value/strings.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Favourites extends StatefulWidget {
  const Favourites({Key? key}) : super(key: key);

  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        color: Colors.red,
      ),
    );
  }
}
