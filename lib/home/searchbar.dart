import 'package:aqua/fetch_parse_JSON/sercices_ridotto.dart';
import 'package:aqua/fetch_parse_JSON/spiagge_ridotto.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {

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

  late FloatingSearchBarController controller;

  @override
  void initState() {
    super.initState();
    controller = FloatingSearchBarController();
    _filteredSearchResults = filterSearchTerms(filter: "");
    ServicesRidotto.getSpiaggeRidotto().then((spiagge) {
      setState(() {
        _spiagge = spiagge;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingSearchBar(
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
                      onTap: (){},
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

/*
return Container(
        child: FloatingSearchBar(
            margins: const EdgeInsets.only(top: 68.0, left: 45.0, right: 10.0),
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
            borderRadius: BorderRadius.circular(30.0),
            debounceDelay: const Duration(milliseconds: 500),
            clearQueryOnClose: true,
            onQueryChanged: (query) {
              // Call your model, bloc, controller here.
            },
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
                    child: Container(
                      child: Column(
                        children: [
                          ListView.builder(
                              itemCount: null == _spiagge ? 0 : _spiagge.length,
                              itemBuilder: (context, index) => ListTile(
                                  title: Text(_spiagge[index].name),
                                )
                              ),
                        ],
                      ),
                    )
                  ));
            }));



ListView.builder(
                        itemCount: null == _spiagge ? 0 : _spiagge.length,
                        itemBuilder: (context, index) {
                          SpiaggiaRidotto spiaggia = _spiagge[index];
                          return ListTile(
                            title: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.grey[300],
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: 20.0,
                                ),
                                child: Expanded(
                                  child: Text(
                                    spiaggia.name,
                                    style: TextStyle(
                                      fontSize: 30,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),*/
