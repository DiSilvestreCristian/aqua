import 'package:flutter/material.dart';
import 'package:aqua/home.dart';
import 'package:aqua/favourites.dart';
import 'package:aqua/rank.dart';
import 'package:aqua/info.dart';

class BottomNavBar extends StatefulWidget{
  @override
  State<BottomNavBar> createState() => _BottomNavBar();
}

class _BottomNavBar extends State<BottomNavBar>{

  int _currentIndex =0;

  List<Widget> _widgetOptions = <Widget>[
    Home(),
    Favourites(),
    Rank(),
    Info()
  ];

  void _onItemTap (int index){
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      body: _widgetOptions.elementAt(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue[600],
        unselectedItemColor: Colors.grey[700],
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home')
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              title: Text('Preferiti')
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.grade),
              title: Text('Classifica')
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.info),
              title: Text('Info')
          ),
        ],
        currentIndex: _currentIndex,
        onTap: _onItemTap,
      ),
    );
  }
}
