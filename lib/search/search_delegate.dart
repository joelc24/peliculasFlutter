

import 'package:flutter/material.dart';

class MovieSearchDelegate extends SearchDelegate{

  @override
  String get searchFieldLabel => "Buscar Pelicula";

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      const Text('Lista de acciones'),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return const Text('buildLeading');
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('Resultados');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return  Text('buildSuggestions $query');
  }



}