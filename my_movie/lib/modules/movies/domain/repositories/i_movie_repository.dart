import '../entities/movie.dart';

abstract class IMovieRepository {
  Future<List<Movie>> getAll();
  Future<Movie> getOne(int id);
}
