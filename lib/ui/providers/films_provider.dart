import 'package:flutter/material.dart';
import 'package:star_wars_app/domain/entities/entity.dart';
import 'package:star_wars_app/domain/usecases/add_favorite_film_usecase_interface.dart';
import 'package:star_wars_app/domain/usecases/fetch_films_usecase_interface.dart';

class FilmsProvider extends ChangeNotifier {
  final IAddFavoriteFilmUsecase _addFavorite;
  final IFetchFilmsUsecase _fetchApi;

  FilmsProvider(this._addFavorite, this._fetchApi);

  List favoriteFilms = [];
  List films = [];

  void fetch() async {
    final result = await _fetchApi();
    films = result;
  }

  Future<bool> addFavorite(Entity entity) async {
    return _addFavorite(entity);
  }
}
