import 'package:flutter/material.dart';

import '../screen/details.dart';

class MovieComponent extends StatelessWidget {
  const MovieComponent(
      {super.key,
      required this.id,
      required this.title,
      required this.voteAverage,
      required this.urlImage});
  final int id;
  final String title;
  final double voteAverage;
  final String urlImage;

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Stack(
        children: <Widget>[
          IconButton(
            iconSize: 150,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Details(title: title, id: id);
              }));
            },
            icon: FadeInImage(
              image: NetworkImage(urlImage),
              placeholder: AssetImage('assets/images/loading.gif'),
              imageErrorBuilder: (context, error, stackTrace) {
                return Image.asset('assets/images/noMovie.png',
                    fit: BoxFit.fitWidth);
              },
              fit: BoxFit.fitWidth,
            ),
          ),
          Positioned(
              //positioned helps to position widget wherever we want.
              top: 10,
              right: 50, //position of the widget
              child: Container(
                  height: 15,
                  width: 20,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.grey
                          .withOpacity(0.7) //background color with opacity
                      ))),
          Positioned(
            top: 10,
            right: 50,
            width: 20,
            child: Text(voteAverage.toString(),
                style: const TextStyle(fontSize: 10),
                textAlign: TextAlign.center),
          ),
        ],
      ),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              constraints: BoxConstraints(minWidth: 100, maxWidth: 150),
              padding: EdgeInsets.all(8),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: Text(title))
        ],
      )
    ]);
  }
}
