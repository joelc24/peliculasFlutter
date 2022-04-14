

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../providers/movies_providers.dart';

class MovieSearchDelegate extends SearchDelegate{

  @override
  String get searchFieldLabel => "Buscar Pelicula";

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = '',
        
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('Resultados');
  }

  Widget _emptyContainer(){
    return Container(
        child: const Center(
          child: Icon(Icons.movie_creation_outlined, color: Colors.black38, size: 130,),
        ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if(query.isEmpty) {
      return _emptyContainer();
    }

    final moviesProvider = Provider.of<MoviesProvider>(context);

    return FutureBuilder(
      future: moviesProvider.searchMovie(query),
      builder: (_, AsyncSnapshot<List<Movie>> snapshot) {

        if(!snapshot.hasData) return _emptyContainer();

        final movies = snapshot.data!;

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (_, int index) => _MovieItem(movie: movies[index]),

        );
      },
    );
  }



}

class _MovieItem extends StatelessWidget {

  final Movie movie;

  const _MovieItem({ Key? key, required this.movie }) : super(key: key);


  @override
  Widget build(BuildContext context) {

    movie.heroId = '${movie.id}-search';

    return ListTile(
      leading: Hero(
        tag: movie.heroId!,
        child: FadeInImage(
          placeholder: const AssetImage('assets/no-image.jpg'), 
          image: NetworkImage(movie.getPosterPath),
          width: 50,
          fit: BoxFit.contain
        ),
      ),
      title: Text(movie.title),
      subtitle: Text(movie.releaseDate ?? ''),
      onTap: () => Navigator.pushNamed(context, 'details', arguments: movie),
    );
  }
}

