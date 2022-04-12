import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/movies_providers.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

 

  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context);

    print(moviesProvider.onDisplayMovies);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Peliculas en Cines'),
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {}
          ),
        ],

      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Tarjetas Principales
            CardSwiper( movies: moviesProvider.onDisplayMovies ),
      
            // Slider de Peliculas
            const MovieSlider(),
          ],
        ),
      ),
    );
  }
}