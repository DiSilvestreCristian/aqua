import 'package:aqua/value/colors.dart';
import 'package:aqua/value/strings.dart';
import 'package:flutter/material.dart';

class AddFavourites extends StatelessWidget {
  const AddFavourites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              addFavourite,
              style: TextStyle(
                fontSize: 18.0,
                color: colorSecondary
              ),
            ),
          ),
          SizedBox(height: 10,),
          Icon(
            Icons.add_circle,
            size: 40,
            color: colorSecondary,
          )
        ],
    );
  }
}
