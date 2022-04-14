import 'package:flutter/material.dart';
import 'package:peliculas/models/models.dart';

import '../widgets/casting_cards.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

 

  @override
  Widget build(BuildContext context) {

    final Movie movie = ModalRoute.of(context)?.settings.arguments as Movie;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _CustomAppBar(movie: movie),
          SliverList(
            delegate: SliverChildListDelegate([
              _PosterAndTitle(movie: movie),
              _Overview(movie: movie),
              _Overview(movie: movie),
              _Overview(movie: movie),
              CastingCards( movieId: movie.id),
            ]),
          ),
        ],
      ),
    );
  }
}


class _CustomAppBar extends StatelessWidget {
  const _CustomAppBar({ Key? key, required this.movie }) : super(key: key);

  final Movie movie;
  @override
  Widget build(BuildContext context) {
    return  SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
          color: Colors.black12,
          child: Text(
            movie.title,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        background:  FadeInImage(
          placeholder: const AssetImage('assets/loading.gif'),
          image: NetworkImage(movie.getBackdropPath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  const _PosterAndTitle({ Key? key,  required this.movie }) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {

    final textTheme = Theme.of(context).textTheme; 
    final size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: const AssetImage('assets/no-image.jpg'),
              image: NetworkImage(movie.getPosterPath),
              height: 150,
              width: 110,
            ),
          ),
          const SizedBox(width: 20),

          ConstrainedBox(
            constraints:  BoxConstraints(maxWidth: (size.width - 160) * 0.9),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
          
                Text(movie.title, style: textTheme.headline5, overflow: TextOverflow.ellipsis, maxLines: 2),
          
                Text(movie.originalTitle, style: textTheme.subtitle1, overflow: TextOverflow.ellipsis, maxLines: 2),
          
                Row(
                  children:  <Widget>[
                    const Icon(Icons.star_outline, color: Colors.grey, size: 15),
                    const SizedBox(width: 5),
                    Text('${movie.voteAverage}', style: textTheme.caption, overflow: TextOverflow.ellipsis, maxLines: 1),
                  ]
                ),
          
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  const _Overview({ Key? key, required this.movie }) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(movie.overview,
      textAlign: TextAlign.justify,
      style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}