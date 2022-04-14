

import 'dart:async';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../helpers/debouncer.dart';
import '../models/models.dart';

class MoviesProvider extends ChangeNotifier {

  final String _apiKey = '587601a37c6d1275f62efb95b0d9b501';
  final String _baseUrl = 'api.themoviedb.org';
  final String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  Map<int, List<Cast>> moviesCast = {};

  int _popularPage = 0;

  final debouncer = Debouncer(
    duration: const Duration(milliseconds: 500),
  );


  final StreamController<List<Movie>> _suggestionsStreamController = StreamController.broadcast();

  Stream<List<Movie>> get suggestionsStream => _suggestionsStreamController.stream;



  MoviesProvider(){

    getOnDisplayMovies();
    getPopularMovies();
  }


  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    final url = Uri.https(_baseUrl, endpoint, {
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

  Future<List<Cast>> getMovieCast(int id) async {

    if (moviesCast.containsKey(id)) return moviesCast[id]!;
    
    final json = await _getJsonData('3/movie/$id/credits');
    final creditsResponse = CreditsResponse.fromJson(json);

    moviesCast[id] = creditsResponse.cast;

    return creditsResponse.cast;

  }

  Future<List<Movie>> searchMovie(String query) async {

    final url = Uri.https(_baseUrl, '3/search/movie', {
      'api_key': _apiKey,
      'language': _language,
      'query': query,  
    });

    final response = await http.get(url);
    final searchResponse = SearchResponse.fromJson(response.body);

    return searchResponse.results;

  }

  void getSuggestionsByQuery(String searchTerm);

}