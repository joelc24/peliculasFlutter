

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../models/models.dart';

class MoviesProvider extends ChangeNotifier {

  final String _apiKey = '587601a37c6d1275f62efb95b0d9b501';
  final String _baseUrl = 'api.themoviedb.org';
  final String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  int _popularPage = 0;

  MoviesProvider(){

    getOnDisplayMovies();
    getPopularMovies();
  }


  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    dynamic url = Uri.https(_baseUrl, endpoint, {
      'api_key': _apiKey,
      'language': _language,
      'page': '$page',
       
      });

      final response = await http.get(url);
      return response.body;
  }

  getOnDisplayMovies() async {
      
      final json = await _getJsonData('3/movie/now_playing');
      final nowPlayingResponse = NowPlayingResponse.fromJson(json);

      onDisplayMovies = nowPlayingResponse.results;
      notifyListeners();
  }

  getPopularMovies() async {
    _popularPage++;

      final json = await _getJsonData('3/movie/popular', _popularPage);
      final popularResponse = PopularResponse.fromJson(json);

      popularMovies = [ ...popularMovies, ...popularResponse.results];

      notifyListeners();
  }

}