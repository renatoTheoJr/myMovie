import 'package:flutter/foundation.dart';

class Movie {
  int id;
  double voteAverage;
  String title;
  String image;
  List genres = [];
  String releaseDate;
  String? overview;
  int? runTime;
  Movie(this.id, this.voteAverage, this.title, this.image, this.genres,
      this.releaseDate,
      {this.overview, this.runTime});

  factory Movie.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as int;
    final voteAverage = json['vote_average'] as double;
    final runtime = json['runtime'] as int;
    final genres = json['genres'].map((genre) => genre).toList();
    return Movie(id, voteAverage, json['original_title'], json['poster_url'],
        genres, json['release_date'],
        overview: json['overview'], runTime: runtime);
  }
}
