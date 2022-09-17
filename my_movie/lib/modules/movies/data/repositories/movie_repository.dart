import 'package:my_movie/modules/movies/domain/entities/movie.dart';
import 'dart:convert';
import '../../domain/repositories/i_movie_repository.dart';
import '../../datasource/request_movie.dart';

class MovieRepository implements IMovieRepository {
  final request = RequestMovie();
  List<Movie> _repositories = [];
  @override
  Future<List<Movie>> getAll() async {
    try {
      var response = await request.getMovies();
      _repositories = (response.data as List)
          .map((movie) => Movie(
              movie['id'],
              movie['vote_average'],
              movie['title'],
              movie['poster_url'],
              movie['genres'],
              movie['release_date']))
          .toList();
      /*responseBody.forEach((movie) {
        _repositories.add(Movie(movie.id, movie.vote_average, movie.title,
            movie.poster_url, movie.genres, movie.releaseDate));
      });*/
    } catch (e) {
      print(e);
    }
    return _repositories;
  }

  @override
  Future<Movie> getOne(int id) async {
    var response = await request.getMovie(id);
    Movie mv = Movie.fromJson(response.data);
    //print("teste" + mv.id.toString());
    return mv;
  }
}
