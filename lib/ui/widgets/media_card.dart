import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:star_wars_app/domain/entities/entity.dart';
import 'package:star_wars_app/ui/providers/films_provider.dart';

class MediaCard extends ConsumerWidget {
  final Entity entity;
  const MediaCard({Key? key, required this.entity}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final width = MediaQuery.of(context).size.width;
    // final height = MediaQuery.of(context).size.height;
    // final Future _filmsProvider = ref.watch(filmsProvider.future);
    // final Future _charactersProvider = ref.watch(filmsProvider);

    return Center(
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.album),
              title: Text(entity.name),
              trailing: Icon(
                Icons.favorite,
                color: entity.favorite ? Colors.red : Colors.grey,
                size: 24.0,
              ),
              onTap: () async {
                final bool response;
                if (entity.toString() == 'characters') {
                  // await _charactersProvider.addFavorite(entity);
                  response = await context.read<FilmsProvider>().addFavorite(entity);
                } else {
                  response = await context.read<FilmsProvider>().addFavorite(entity);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
