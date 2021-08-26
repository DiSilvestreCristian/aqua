import 'package:flutter/material.dart';

class InfoDetails extends StatelessWidget {

  final String pollutant;

  InfoDetails({
    Key? key,
    required this.pollutant,
  }) : super(key: key);

  Widget build(BuildContext context) {

    Widget infoPollutant ;
    switch (pollutant){
      case "ostreopsis" : infoPollutant = InfoOstreopsis();
      break;
      case "escherichia" : infoPollutant = InfoEscherichia();
      break;
      case "enterococcus" : infoPollutant = InfoEnterococcus();
      break;
      default : infoPollutant = InfoOstreopsis();
    }

    return Scaffold(
        body: Container(
          padding: EdgeInsets.only(top: 50.0, right: 8.0, bottom: 0.0, left: 8.0),
        child: SingleChildScrollView(
          child: Card(
            color: Colors.grey[300],
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
             child : infoPollutant,
          ),
        )
        )
    );
  }
}

class InfoOstreopsis extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(8.0),
      child: Expanded(
          child: Text.rich (
            TextSpan(text: "Ostreopsis ", style: TextStyle(fontStyle: FontStyle.italic),
                children:<TextSpan>[
                  TextSpan(text: "cf. ", style: TextStyle(fontStyle: FontStyle.normal)),
                  TextSpan(text: "ovata", style: TextStyle(fontStyle: FontStyle.italic)),
                  TextSpan(text: "- Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
                      "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. "
                      "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi "
                      "ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit "
                      "in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur "
                      "sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt "
                      "mollit anim id est laborum. "
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
                      "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. "
                      "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi "
                      "ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit "
                      "in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur "
                      "sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt "
                      "mollit anim id est laborum. "
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
                      "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. "
                      "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi "
                      "ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit "
                      "in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur "
                      "sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt "
                      "mollit anim id est laborum. "
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
                      "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. "
                      "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi "
                      "ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit "
                      "in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur "
                      "sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt "
                      "mollit anim id est laborum. ", style: TextStyle(fontStyle: FontStyle.normal)),
                ]
            ),
            style: TextStyle(fontSize: 18),
            softWrap: true,)
      ),
    );
  }
}

class InfoEscherichia extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Expanded(
          child: Text.rich (
            TextSpan(text: "Escherichia coli ", style: TextStyle(fontStyle: FontStyle.italic),
                children:<TextSpan>[
                  TextSpan(text: "- Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
                      "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. "
                      "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi "
                      "ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit "
                      "in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur "
                      "sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt "
                      "mollit anim id est laborum. "
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
                      "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. "
                      "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi "
                      "ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit "
                      "in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur "
                      "sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt "
                      "mollit anim id est laborum. "
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
                      "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. "
                      "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi "
                      "ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit "
                      "in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur "
                      "sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt "
                      "mollit anim id est laborum. "
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
                      "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. "
                      "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi "
                      "ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit "
                      "in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur "
                      "sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt "
                      "mollit anim id est laborum. ", style: TextStyle(fontStyle: FontStyle.normal)),
                ]
            ),
            style: TextStyle(fontSize: 18),
            softWrap: true,)
      ),
    );
  }
}

class InfoEnterococcus extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Expanded(
          child: Text.rich (
            TextSpan(text: "Enterococchi ", style: TextStyle(fontStyle: FontStyle.italic),
                children:<TextSpan>[
                  TextSpan(text: "- Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
                      "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. "
                      "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi "
                      "ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit "
                      "in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur "
                      "sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt "
                      "mollit anim id est laborum. "
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
                      "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. "
                      "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi "
                      "ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit "
                      "in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur "
                      "sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt "
                      "mollit anim id est laborum. "
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
                      "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. "
                      "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi "
                      "ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit "
                      "in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur "
                      "sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt "
                      "mollit anim id est laborum. "
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
                      "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. "
                      "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi "
                      "ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit "
                      "in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur "
                      "sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt "
                      "mollit anim id est laborum. ", style: TextStyle(fontStyle: FontStyle.normal)),
                ]
            ),
            style: TextStyle(fontSize: 18),
            softWrap: true,)
      ),
    );
  }
}
