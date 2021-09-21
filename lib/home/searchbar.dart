import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
     child: FloatingSearchBar(
       margins: const EdgeInsets.only(top: 68.0,left: 45.0, right: 10.0),
       hint: 'Cerca...',
       scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
       transitionDuration: const Duration(milliseconds: 800),
       transitionCurve: Curves.easeInOut,
       physics: const BouncingScrollPhysics(),
       axisAlignment: 0.0,
       openAxisAlignment: 0.0,
       width: 600,
       elevation: 0,
       backdropColor: Color(0x00FFFFFF),
       debounceDelay: const Duration(milliseconds: 500),
       onQueryChanged: (query) {
         // Call your model, bloc, controller here.
       },
       transition: CircularFloatingSearchBarTransition(),
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
       builder: (context, transition) {
         return ClipRRect(
           borderRadius: BorderRadius.circular(8),
           child: Material(
             color: Colors.white,
             elevation: 4.0,
             child: Column(
               mainAxisSize: MainAxisSize.min,
               children: Colors.accents.map((color) {
                 return Container(height: 112, color: color);
               }).toList(),
             ),
           ),
         );
       },
     )
    );
  }
}
