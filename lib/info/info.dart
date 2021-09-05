import 'package:aqua/info/info_details.dart';
import 'package:aqua/value/string.dart';
import 'package:flutter/material.dart';


class Info extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
        body: Center(
            child: Padding(
              padding: EdgeInsets.only(top: 50.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: (EdgeInsets.only(left: 15.0)),
                      child: Text(
                        titoloInfo,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 45),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  GestureDetector(
                  onTap: () {
                    //Navigator.of(context).pushNamed('/home');
                    Navigator.push(
                      context,
                        PageRouteBuilder(pageBuilder: (_, __, ___) => InfoDetails(pollutant: ostreopsisName)),
                    );
                  },
                    child: Card(
                      color: Colors.grey[300],
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                            'images/ostreopsis.jpg',
                            height: 170,
                            width: 420,
                            fit: BoxFit.cover
                        ),
                        Container(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                                children: [
                                  Expanded(
                                      child: Text.rich (
                                        ostreopsisPreview,
                                        style: TextStyle(fontSize: 18),
                                        softWrap: true,)
                                  ),
                                  Icon(Icons.arrow_forward_ios, color: Colors.blue[600],)
                                ]
                            )
                        )
                      ],
                    ),
                  ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(pageBuilder: (_, __, ___) => InfoDetails(pollutant: escherichiaName)),
                      );
                    },
                    child: Card(
                        color: Colors.grey[300],
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Column(
                          children: [
                            Image.asset(
                                'images/escherichia.jpg',
                                height: 170,
                                width: 420,
                                fit: BoxFit.cover
                            ),
                            Container(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                    children: [
                                      Expanded(
                                          child: Text (
                                            escherichiaPreview,
                                            style: TextStyle(fontSize: 18),
                                            softWrap: true,)
                                      ),
                                      Icon(Icons.arrow_forward_ios, color: Colors.blue[600],)
                                    ]
                                )
                            )
                          ],
                        )
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(pageBuilder: (_, __, ___) => InfoDetails(pollutant: enterococcusName)),
                      );
                    },
                    child: Card(
                        color: Colors.grey[300],
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Column(
                          children: [
                            Image.asset(
                                'images/enterococcus.jpg',
                                height: 170,
                                width: 420,
                                fit: BoxFit.cover
                            ),
                            Container(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                    children: [
                                      Expanded(
                                          child: Text (
                                            enterococcusPreview,
                                            style: TextStyle(fontSize: 18),
                                            softWrap: true,)
                                      ),
                                      Icon(Icons.arrow_forward_ios, color: Colors.blue[600],)
                                    ]
                                )
                            )
                          ],
                        )
                    ),
                  )
                ],
              ),
            )
        )
    );
  }
}
