
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../models/models.dart';

class MoviesProvider extends ChangeNotifier {

  String _apiKey = '587601a37c6d1275f62efb95b0d9b501';
  String _baseUrl = 'api.themoviedb.org';
  String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];

  MoviesProvider(){
    print("MoviesProvider Inicializado");

    getOnDisplayMovies();
  }


  getOnDisplayMovies() async {
     var url = Uri.https(_baseUrl, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
      'page': '1',
       
      });

      final response = await http.get(url);
      final nowPlayingResponse = NowPlayingResponse.fromJson(response.body);

      onDisplayMovies = nowPlayingResponse.results;
      notifyListeners();
  }

}