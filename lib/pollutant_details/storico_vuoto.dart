import 'package:aqua/value/colors.dart';
import 'package:flutter/material.dart';

class StoricoVuoto extends StatelessWidget {
  final TextSpan testo;
  const StoricoVuoto({Key? key, required this.testo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0,),
      child: Card(
        color: colorItemBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
            child: Text.rich(testo)
        )
      ),
    );
  }
}
