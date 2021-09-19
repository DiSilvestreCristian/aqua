import 'package:flutter/material.dart';

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
