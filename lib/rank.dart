import 'package:aqua/instance_spiagge.dart';
import 'package:aqua/services.dart';
import 'package:flutter/material.dart';
import 'package:singleton/singleton.dart';
import 'spiaggia.dart';
import 'beach_details.dart';

class Rank extends StatefulWidget {
  const Rank({Key? key}) : super(key: key);

  @override
  _RankState createState() => _RankState();
}

class _RankState extends State<Rank> {

  late List<Spiaggia> _spiagge;

  String pollutantChose = "Ostreopsis cf. ovata";
  List listItem =[
    "Ostreopsis cf. ovata", "Escherichia coli", "Eterococchi"
  ];

  /*@override
  void initState(){
    super.initState();
    asyncMethod().then((spiagge) {
      setState(() {
        _spiagge = spiagge;
      });
    });
  }

  Future<List<Spiaggia>> asyncMethod() async{
    List<Spiaggia> spiagge = await Singleton.ensureInstanceFor(FutureService);
    return spiagge;
  }*/

  @override
  void initState(){
    super.initState();
    Services.getSpiagge().then((spiagge) {
      setState(() {
        _spiagge = spiagge;
      });
    });
  }

  createList(){
    switch(pollutantChose){
      case "Ostreopsis cf. ovata" : _spiagge.sort((a,b)=>a.ostreopsis[0].value.compareTo(b.ostreopsis[0].value));
      break;
      case "Escherichia coli": _spiagge.sort((a,b)=>a.escherichia[0].value.compareTo(b.escherichia[0].value));
      break;
      case "Eterococchi": _spiagge.sort((a,b)=>a.enterococcus[0].value.compareTo(b.enterococcus[0].value));
      break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
            Padding(
              padding: EdgeInsets.only(top: 50.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: (EdgeInsets.only(left: 15.0)),
                      child: Text(
                        "Classifica",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 45),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Container(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(30)
                      ),
                      child: DropdownButton(
                        icon: Icon(Icons.arrow_drop_down,),
                        iconSize: 30,
                        iconEnabledColor: Colors.blue[600],
                        isExpanded: true,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22
                        ),
                        value: pollutantChose,
                        onChanged: (newPollutant){
                          setState(() {
                            pollutantChose = newPollutant.toString();
                            createList();
                          });
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
                  Expanded(
                  child: ListView.builder(
                  itemCount: _spiagge.length,
                  itemBuilder: (context, index) {
                    Spiaggia spiaggia = _spiagge[index];
                    return ListTile(
                      leading: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.blue[600],
                        ),
                        child: Center(
                          child: Text(
                            (index+1).toString(),
                            style: TextStyle(color: Colors.white, fontSize: 30,),
                          ),
                        )
                    ),
                      title: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.grey[300],
                        ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 20.0,),
                        child: Row(
                          children:[ Expanded(
                            child: Text(
                                spiaggia.name,
                                style: TextStyle(fontSize: 30,),
                            ),
                          ),
                            Padding(
                              padding: EdgeInsets.only(right: 20.0,),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(pageBuilder: (_, __, ___) => BeachDetails(spiaggia: spiaggia)),
                                    );
                                  },
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.blue[600],),
                                )
                            ),
                        ],
                        ),
                      ),
                      ),
                    );
                  },
                ),
          ),
    ]
              ),
            ),
    );
  }
}
