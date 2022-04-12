import 'package:flutter/material.dart';

import '../widgets/casting_cards.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

 

  @override
  Widget build(BuildContext context) {

    final String movie = ModalRoute.of(context)?.settings.arguments.toString() ?? 'no-movie';


    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          const _CustomAppBar(),
          SliverList(
            delegate: SliverChildListDelegate([
             const _PosterAndTitle(),
             const _Overview(),
             const _Overview(),
             const _Overview(),
             const CastingCards(),
            ]),
          ),
        ],
      ),
    );
  }
}


class _CustomAppBar extends StatelessWidget {
  const _CustomAppBar({ Key? key }) : super(key: key);

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
          alignment: AlignmentDirectional.bottomCenter,
          color: Colors.black12,
          child: const Text(
            'movie.title',
            style: TextStyle(fontSize: 16),
          ),
        ),
        background: const FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage('https://via.placeholder.com/500x300'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  const _PosterAndTitle({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final textTheme = Theme.of(context).textTheme; 

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: const FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'),
              image: NetworkImage('https://via.placeholder.com/200x300'),
              height: 150,
            ),
          ),
          const SizedBox(width: 20),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('movie.title', style: textTheme.headline5, overflow: TextOverflow.ellipsis, maxLines: 2),
              Text('movie.originalTitle', style: textTheme.subtitle1, overflow: TextOverflow.ellipsis, maxLines: 1),

              Row(
                children:  <Widget>[
                  const Icon(Icons.star_outline, color: Colors.grey, size: 15),
                  const SizedBox(width: 5),
                  Text('movie.voteAverage', style: textTheme.caption, overflow: TextOverflow.ellipsis, maxLines: 1),
                ]
              ),

            ],
          ),
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  const _Overview({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text("Laboris dolor minim culpa voluptate esse velit consequat consequat reprehenderit aliquip anim. Consequat eu Lorem eu pariatur Lorem duis fugiat dolor aute incididunt dolor deserunt cupidatat. Non aliquip officia ipsum ad pariatur sit velit reprehenderit pariatur ullamco. Officia irure cillum dolor anim in cupidatat. Est sunt esse ut ut consectetur magna non deserunt sunt aliquip. Do aliquip fugiat ex magna.",
      textAlign: TextAlign.justify,
      style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}