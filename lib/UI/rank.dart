import 'package:aqua/model/instance_spiagge.dart';
import 'package:aqua/model/spiagge_ridotto.dart';
import 'package:aqua/value/colors.dart';
import 'package:aqua/value/numbers.dart';
import 'package:aqua/value/strings.dart';
import 'package:flutter/material.dart';
import '../UI/beach_details/beach_details.dart';

class Rank extends StatefulWidget {
  const Rank({Key? key}) : super(key: key);

  @override
  _RankState createState() => _RankState();
}

class _RankState extends State<Rank> {

  String pollutantChose = ostreopsisName;
  List listItem =[
    ostreopsisName, escherichiaName, enterococcusName
  ];

  List<SpiaggiaRidotto> _spiagge = [];
  List<SpiaggiaRidotto> _list = [];

  late String presenza;
  late String orderSelected;

  Future<List<SpiaggiaRidotto>> getSingleton(){
    var singleton = new SingletonSpiagge();
    final spiagge = singleton.spiagge;
    return spiagge;
  }

  @override
  void initState() {
    super.initState();
    getSingleton().then((spiagge){
      setState(() {
        _spiagge = spiagge;
      });
    });
    setState(() {
      presenza = minorPresenzaRank;
      orderSelected = ordineCrescente;
    });
  }

  orderList(){
    _list = new List<SpiaggiaRidotto>.from(_spiagge);
    switch(pollutantChose){
      case ostreopsisName : {
        _list.removeWhere((item) => item.ostreopsis == null);
        _list.sort((a,b) {
          int cmp  = 0;
          if (orderSelected == ordineCrescente) cmp = a.ostreopsis.compareTo(b.ostreopsis);
          if (orderSelected == ordineDecrescente) cmp = b.ostreopsis.compareTo(a.ostreopsis);
          if (cmp != 0) return cmp;
          return a.comune.compareTo(b.comune);
        });
        break;
      }
      case escherichiaName: {
        _list.removeWhere((item) => item.escherichia == null);
        _list.sort((a,b){
          int cmp = 0;
          if (orderSelected == ordineCrescente) cmp = a.escherichia.compareTo(b.escherichia);
          if (orderSelected == ordineDecrescente) cmp = b.escherichia.compareTo(a.escherichia);
          if (cmp != 0) return cmp;
          return b.comune.compareTo(a.comune);
        });
        break;
      }
      case enterococcusName: {
        _list.removeWhere((item) => item.enterococcus == null);
        _list.sort((a,b){
          int cmp = 0;
          if (orderSelected == ordineCrescente) cmp = a.enterococcus.compareTo(b.enterococcus);
          if (orderSelected == ordineDecrescente) cmp = b.enterococcus.compareTo(a.enterococcus);
          if (cmp != 0) return cmp;
          return a.comune.compareTo(b.comune);
        });
        break;
      }
    }
  }

  Widget customRadio (String text, String selected){
    return OutlineButton(
        onPressed: (){
          setState(() {
            orderSelected = selected;
            if (selected == ordineCrescente) presenza = minorPresenzaRank;
            if (selected == ordineDecrescente) presenza = maggiorPresenzaRank;
          });
        },
      child: Text(
        text,
        style: TextStyle(
          color: (orderSelected == selected ? colorPrimary : colorSecondary)
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      borderSide: BorderSide(color: (orderSelected == selected ? colorPrimary : colorSecondary)),
    );
  }

  @override
  Widget build(BuildContext context) {
    orderList();
    return Scaffold(
      body:
      Padding(
        padding: EdgeInsets.only(top: 50.0),
        child: Column(
          children: [
            Container(
            padding: (EdgeInsets.only(left: 15.0)),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    titoloRank,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 45),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    selezionaOrdinamento,
                    style: TextStyle(color: colorTextPrimary,fontSize: 25),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    customRadio(ordineCrescente, ordineCrescente),
                    SizedBox(width: 10,),
                    customRadio(ordineDecrescente, ordineDecrescente)
                  ],
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    presenza,
                    style: TextStyle(color: colorTextPrimary,fontSize: 25),
                  ),
                ),
              ],
            ),
          ),
            SizedBox(height: 8),
            Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
                child: Container(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: colorSecondary),
                        borderRadius: BorderRadius.circular(30)
                    ),
                    child: DropdownButton(
                      icon: Icon(Icons.arrow_drop_down,),
                      iconSize: 30,
                      iconEnabledColor: colorPrimary,
                      isExpanded: true,
                      style: TextStyle(
                          color: colorTextPrimary,
                          fontSize: 22
                      ),
                      value: pollutantChose,
                      onChanged: (newPollutant){
                        this.setState(() {
                          pollutantChose = newPollutant.toString();
                        });
                        orderList();
                      },
                      items: listItem.map((valueItem){
                        return DropdownMenuItem(
                          value: valueItem,
                          child: Text(valueItem),
                        );
                      }).toList(),
                    ),
                ),
            ),
            MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: Expanded(
                child: ListView.builder(
                  itemCount: null == _list ? 0 :
                  (_list.length < numberBeachOnRank ? _list.length : numberBeachOnRank),
                  itemBuilder: (context, index) {
                    SpiaggiaRidotto spiaggia = _list[index];
                    return ListTile(
                      leading: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: colorPrimary,
                          ),
                          child: Center(
                            child: Text(
                              (index+1).toString(),
                              style: TextStyle(color: colorTextSecondary, fontSize: 30,),
                            ),
                          )
                      ),
                      title: GestureDetector(
                        child: Container(
                          height: 65,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: colorItemBackground,
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 20.0,),
                            child: Row(
                              children:[ Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                        spiaggia.comune,
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                      ),
                                    Text(
                                        spiaggia.descrizione,
                                        style: TextStyle(fontSize: 13,),
                                        overflow: TextOverflow.ellipsis,
                                    ),

                                  ],
                                ),
                              ),
                                Padding(
                                  padding: EdgeInsets.only(right: 20.0,),
                                  child: Icon(
                                      Icons.arrow_forward_ios,
                                      color: colorPrimary,),
                                )
                              ],
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return  BeachDetails(spiaggia: spiaggia);
                            }),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ]
        ),
      ),
    );
  }
}