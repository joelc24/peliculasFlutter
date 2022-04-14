import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../providers/movies_providers.dart';

class CastingCards extends StatelessWidget {
  const CastingCards({ Key? key, required this.movieId }) : super(key: key);

  final int movieId;

  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProvider.getMovieCast(movieId),
      builder: (_, AsyncSnapshot<List<Cast>> snapshot) {

        if(!snapshot.hasData) {
          return Container(
            constraints: const BoxConstraints(maxWidth: 180),
            height: 180,
            child: const Center(
              child: CupertinoActivityIndicator(),
            ),
          );
        }
      
      final List<Cast> cast = snapshot.data!;

      return Container(
          margin: const EdgeInsets.only(bottom: 30),
          width: double.infinity,
          height: 180,
          child: ListView.builder(
            itemCount: cast.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext _, int index) => _CastCard( actor: cast[index]),
          ),
        );
      },
    );

    
  }
}

class _CastCard extends StatelessWidget {
  const _CastCard({ Key? key, required this.actor }) : super(key: key);

  final Cast actor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      height: 100,
      child: Column(
        children:  [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: const AssetImage('assets/no-image.jpg'),
              image: NetworkImage(actor.getProfilePath),
              width: 100,
              height: 140,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            actor.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),

        ],
      ),
    );
  }
}