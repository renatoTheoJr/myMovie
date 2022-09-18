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
    List<String> allGenres = <String>[
      "Filtrar por gênero",
      "All",
      "Comedy",
      "Drama",
      "Romance",
      "Crime",
      "Animation",
      "History",
      "War",
      "Family",
      "Fantasy",
      "Thriller",
      "Horror"
    ];
    String dropdownValue = allGenres.first;

    return MaterialApp(
      title: 'List Movies',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('MyMovies'),
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
                      id: movie.id,
                      title: movie.title,
                      voteAverage: movie.voteAverage,
                      urlImage: movie.image);
                  return comp;
                }).toList();
                List<Widget> collumns = [];
                List<Widget> rows = [];
                collumns.add(DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      futureMovies = movieRepository.selectByGenre(value);
                      dropdownValue = value!;
                    });
                  },
                  items:
                      allGenres.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ));
                for (int i = 0; i < listData.length; i++) {
                  rows.add(listData[i]);
                  if ((i + 1) % 2 == 0) {
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
                return CustomScrollView(slivers: <Widget>[
                  const SliverAppBar(
                    pinned: true,
                    expandedHeight: 100.0,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text('MyMovies'),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return Container(
                            alignment: Alignment.center,
                            //color: Colors.blue[200 + top[index] % 4 * 100],
                            // height: 100 + * 20.0,
                            child: collumns[index]);
                      },
                      childCount: collumns.length,
                    ),
                  )
                ]);
              } else if (snapshot.hasError) {
                return const Text('Houve um erro ao carregar as informações');
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
