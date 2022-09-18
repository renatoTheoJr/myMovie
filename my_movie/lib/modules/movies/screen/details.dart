import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../data/repositories/movie_repository.dart';
import '../domain/entities/movie.dart';

class Details extends StatefulWidget {
  const Details({Key? key, required this.title, required this.id})
      : super(key: key);
  final String title;
  final int id;

  @override
  State<StatefulWidget> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final MovieRepository movieRepository = MovieRepository();
  late Future<Movie> movie;

  @override
  void initState() {
    super.initState();
    movie = movieRepository.getOne(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: widget.title,
        theme: ThemeData(
            primarySwatch: Colors.purple,
            scaffoldBackgroundColor: const Color.fromRGBO(61, 28, 81, 1)),
        home: Scaffold(
            appBar: AppBar(
              title: Text(widget.title),
            ),
            body: Center(
                child: FutureBuilder<Movie>(
                    future: movie,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        Movie data = snapshot.data!;
                        var listGenres = data.genres.map((genres) {
                          return Container(
                              padding: const EdgeInsets.all(4),
                              margin: const EdgeInsets.only(
                                  left: 20.0, bottom: 10.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:
                                      const Color.fromRGBO(217, 217, 217, 0.1),
                                  border: Border.all(
                                      color:
                                          const Color.fromRGBO(0, 0, 0, 0.5))),
                              child: Text(genres,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)));
                        }).toList();
                        return CustomScrollView(
                          scrollDirection: Axis.horizontal,
                          primary: false,
                          slivers: <Widget>[
                            SliverPadding(
                              padding: const EdgeInsets.all(7),
                              sliver: SliverGrid.count(
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                crossAxisCount: 2,
                                children: <Widget>[
                                  Container(
                                      padding: const EdgeInsets.all(1),
                                      margin: const EdgeInsets.all(2),
                                      child: Column(children: <Widget>[
                                        FadeInImage(
                                          height: 280,
                                          width: 280,
                                          image: NetworkImage(data.image),
                                          placeholder: const AssetImage(
                                              "assets/images/noMovie.png"),
                                          imageErrorBuilder:
                                              (context, error, stackTrace) {
                                            return Image.asset(
                                                'assets/images/noMovie.png');
                                          },
                                        ),
                                        Text("Lançado em ${data.releaseDate}",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromRGBO(
                                                    255, 255, 255, 0.5))),
                                        Text("${data.runTime.toString()} min",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromRGBO(
                                                    255, 255, 255, 0.5)))
                                      ])),
                                  Container(
                                      padding: const EdgeInsets.all(4),
                                      child: Column(children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            ...listGenres
                                            // return listGenres
                                          ],
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              bottom: 20.0),
                                          child: Text(
                                            data.overview!,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontFamily: "Roboto",
                                                fontSize: 17.0),
                                          ),
                                        ),
                                        Row(
                                          children: <Widget>[
                                            const Icon(Icons.star,
                                                color: Colors.yellow),
                                            Text(
                                                "${data.voteAverage.toString()}/10",
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ))
                                          ],
                                        )
                                      ])),
                                ],
                              ),
                            ),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return const Center(
                            child: Text(
                                "Houve um erro ao carregar as informações, por favor cheque sua conexão com a internet."));
                      }
                      return const CircularProgressIndicator();
                    }))));
  }
}
