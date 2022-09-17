import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

class RequestMovie {
  Future getMovies() async {
    DioCacheManager _dioCacheManager = DioCacheManager(CacheConfig());
    Dio dio = Dio();
    dio.interceptors.add(_dioCacheManager.interceptor);
    Options _cacheOptions = buildCacheOptions(Duration(days: 7),
        forceRefresh: true, primaryKey: 'all');

    var response = dio.get(
        'https://desafio-mobile.nyc3.digitaloceanspaces.com/movies-v2',
        options: _cacheOptions);
    return response;
  }

  Future getMovie(int id) async {
    DioCacheManager _dioCacheManager = DioCacheManager(CacheConfig());
    Dio dio = Dio();
    dio.interceptors.add(_dioCacheManager.interceptor);
    Options _cacheOptions = buildCacheOptions(Duration(days: 7),
        forceRefresh: true, primaryKey: id.toString());

    String idStr = id.toString();
    var response = dio.get(
        'https://desafio-mobile.nyc3.digitaloceanspaces.com/movies-v2/${idStr}',
        options: _cacheOptions);
    return response;
  }
}
