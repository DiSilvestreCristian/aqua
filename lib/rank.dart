import 'package:flutter/material.dart';

import 'spiaggia.dart';
import 'services.dart';

class Rank extends StatefulWidget {
  const Rank({Key? key}) : super(key: key);

  @override
  _RankState createState() => _RankState();
}

class _RankState extends State<Rank> {

  late List<Spiaggia> _spiagge;

  @override
  void initState(){
    super.initState();
    Services.getSpiagge().then((spiagge) {
      setState(() {
        _spiagge = spiagge;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: ListView.builder(
            itemCount: null == _spiagge ? 0 : _spiagge.length,
            itemBuilder: (context, index) {
              Spiaggia spiaggia = _spiagge[index];
              return ListTile(
                title: Text(spiaggia.name),
                subtitle: Text(spiaggia.id),
              );
            },
          ),
        )
    );
  }
}
