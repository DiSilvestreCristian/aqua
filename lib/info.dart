import 'package:flutter/material.dart';
import 'package:aqua/main.dart';

class Info extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
        body: Center(
            child: Padding(padding: EdgeInsets.only(top: 50.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: (EdgeInsets.only(left: 15.0)),
                      child: Text(
                        "Info",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 45),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/info_details',);
                  },
                    child: Card(
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
                                        TextSpan(text: "Ostreopsis ", style: TextStyle(fontStyle: FontStyle.italic),
                                            children:<TextSpan>[
                                              TextSpan(text: "cf. ", style: TextStyle(fontStyle: FontStyle.normal)),
                                              TextSpan(text: "ovata", style: TextStyle(fontStyle: FontStyle.italic)),
                                              TextSpan(text: ": tutto quello che devi sapere sull'alga tossica", style: TextStyle(fontStyle: FontStyle.normal)),
                                            ]
                                        ),
                                        style: TextStyle(fontSize: 18),
                                        softWrap: true,)
                                  ),
                                  Icon(Icons.arrow_forward_ios, color: Colors.blue[500],)
                                ]
                            )
                        )
                      ],
                    ),
                  ),
                  ),
                  Card(
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
                                          "Escherichia Coli. Che cos’é? Quanti tipi ce ne sono?",
                                          style: TextStyle(fontSize: 18),
                                          softWrap: true,)
                                    ),
                                    Icon(Icons.arrow_forward_ios, color: Colors.blue[500],)
                                  ]
                              )
                          )
                        ],
                      )
                  ),
                  Card(
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
                                          "Enterococchi. Perché ci impediscono di fare il bagno?",
                                          style: TextStyle(fontSize: 18),
                                          softWrap: true,)
                                    ),
                                    Icon(Icons.arrow_forward_ios, color: Colors.blue[500],)
                                  ]
                              )
                          )
                        ],
                      )
                  )
                ],
              ),
            )
        )
    );
  }
}
