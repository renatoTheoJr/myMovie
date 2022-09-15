import 'package:dio/dio.dart';

class RequestMovie {
  Future getMovies() async {
    var response = await Dio()
        .get('https://desafio-mobile.nyc3.digitaloceanspaces.com/movies-v2');
    return response;
  }
}
