import 'package:flutter/material.dart';

class MovieComponent extends StatelessWidget {
  const MovieComponent(
      {super.key,
      required this.title,
      required this.voteAverage,
      required this.urlImage});
  final String title;
  final double voteAverage;
  final String urlImage;

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Stack(children: <Widget>[
        Image.network(urlImage),
        Positioned(
            //positioned helps to position widget wherever we want.
            top: 9,
            right: 20, //position of the widget
            child: Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.grey
                        .withOpacity(0.3) //background color with opacity
                    ))),
        Positioned(
          top: 10,
          right: 20,
          width: 20,
          child: Text(voteAverage.toString()),
        ),
      ]),
      Text(title),
    ]);
  }
}
