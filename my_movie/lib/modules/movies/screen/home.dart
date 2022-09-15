import 'package:flutter/material.dart';
import 'package:my_movie/modules/movies/components/movie_component.dart';
import 'package:my_movie/modules/movies/data/repositories/movie_repository.dart';
import 'package:my_movie/modules/movies/domain/entities/movie.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<StatefulWidget> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final MovieRepository movieRepository = MovieRepository();
  late Future<List<Movie>> futureMovies;

  @override
  void initState() {
    super.initState();
    futureMovies = movieRepository.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<List<Movie>>(
            future: futureMovies,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Movie> data = snapshot.data!;
                Widget comp;
                var listData = data.map((movie) {
                  comp = MovieComponent(
                      title: movie.title,
                      voteAverage: movie.voteAverage,
                      urlImage: movie.image);
                  return comp;
                }).toList();
                List<Widget> collumns = [];
                List<Widget> rows = [];

                for (int i = 0; i < listData.length; i++) {
                  rows.add(listData[i]);
                  if ((i + 1) % 3 == 0) {
                    collumns.add(Row(
                      children: [...rows],
                    ));
                    rows = [];
                  }
                }
                if (rows != []) {
                  collumns.add(Row(
                    children: [...rows],
                  ));
                }

                return ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(children: [...collumns]));
                  },
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
