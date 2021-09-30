import 'package:aqua/bottom_nav_bar/tab_navigator.dart';
import 'package:aqua/value/colors.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget{
  @override
  State<BottomNavBar> createState() => _BottomNavBar();
}

class _BottomNavBar extends State<BottomNavBar>{
  String _currentPage = "Home";
  List<String> pageKeys = ["Home", "Favourites", "Rank", "Info"];
  Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    "Home": GlobalKey<NavigatorState>(),
    "Favourites": GlobalKey<NavigatorState>(),
    "Rank": GlobalKey<NavigatorState>(),
    "Info": GlobalKey<NavigatorState>(),
  };
  int _currentIndex =0;

  void _selectTab (String tabItem, int index){
    if (tabItem== _currentPage){
      _navigatorKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);
    } else{
      setState(() {
        _currentIndex = index;
        _currentPage = pageKeys[index];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
      final isFirstRouteInCurrentTab =
      !await _navigatorKeys[_currentPage]!.currentState!.maybePop();
      if (isFirstRouteInCurrentTab) {
        if (_currentPage != "Home") {
          _selectTab("Home", 1);

          return false;
        }
      }
      // let system handle back button if we're on the first route
      return isFirstRouteInCurrentTab;
    },
      child: Scaffold (
      body: Stack(
          children:<Widget>[
            _buildOffstageNavigator("Home"),
            _buildOffstageNavigator("Favourites"),
            _buildOffstageNavigator("Rank"),
            _buildOffstageNavigator("Info"),
          ]
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: colorPrimary,
        unselectedItemColor: colorSecondary,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Preferiti'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.sort),
              label: 'Classifica'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.info),
              label: 'Info'
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (int index) {_selectTab(pageKeys[index], index);},
      ),
    )
    );
  }


  Widget _buildOffstageNavigator(String tabItem) {
    return Offstage(
      offstage: _currentPage != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem]!,
        tabItem: tabItem,
      ),
    );
  }
}
