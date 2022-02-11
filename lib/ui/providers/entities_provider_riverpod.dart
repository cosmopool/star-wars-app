import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import 'package:star_wars_app/data/datasource/api_datasource.dart';
import 'package:star_wars_app/data/datasource/sqlite_database_manager.dart';
import 'package:star_wars_app/data/datasource/sqllite_datasource.dart';
import 'package:star_wars_app/domain/entities/character_entity.dart';
import 'package:star_wars_app/domain/entities/entity.dart';
import 'package:star_wars_app/domain/usecases/add_favorite_character_usecase_interface.dart';
import 'package:star_wars_app/domain/usecases/add_favorite_film_usecase_interface.dart';
import 'package:star_wars_app/infra/repositories/favorites_repository.dart';


  final pathProvider = FutureProvider<String>((ref) async {
    return await SqliteDatabaseManager.getDatabasePath('starwars');
  });

  final databaseProvider = FutureProvider<Database>((ref) async {
    final path = await ref.refresh(pathProvider.future);
    return await SqliteDatabaseManager.openOrCreateDatabase(path);
  });

  final cacheProvider = FutureProvider<SqliteDatasource>((ref) async {
    final database = await ref.refresh(databaseProvider.future);
    return SqliteDatasource(database);
  });

  final apiProvider = Provider<ApiDatasource>((ref) => ApiDatasource());

  final favoritesProvider = FutureProvider<FavoritesRepository>((ref) async {
    final cache = await ref.refresh(cacheProvider.future);
    return FavoritesRepository(cache);
  });

  final addFilmsUsecaseProvider = FutureProvider<AddFavoriteFilmUsecase>((ref) async {
    final repository = await ref.refresh(favoritesProvider.future);
    return AddFavoriteFilmUsecase(repository);
  });

  final addCharacterUsecaseProvider = FutureProvider<AddFavoriteCharacterUsecase>((ref) async {
    final repository = await ref.refresh(favoritesProvider.future);
    return AddFavoriteCharacterUsecase(repository);
  });

  final filmsProvider = FutureProvider<FilmsProvider>((ref) async {
    final addFavoriteFilm = await ref.refresh(addFilmsUsecaseProvider.future);
    return FilmsProvider(addFavoriteFilm);
  });

  final charactersProvider = FutureProvider<CharactersProvider>((ref) async {
    final addFavoriteCharacter = await ref.refresh(addFilmsUsecaseProvider.future);
    return CharactersProvider(addFavoriteCharacter);
  });

// final entitiesProvider = ChangeNotifierProvider<FilmsProvider>((ref) {
//   return filmsProvider();
// });

final webViewIsActive = StateProvider<bool>((ref) {
  return false;
});

final contentList = StateProvider<List>((ref) {
  return [];
});

class CharactersProvider extends ChangeNotifier {
  final IAddFavoriteFilmUsecase _addFavoriteCharacter;

  CharactersProvider(this._addFavoriteCharacter);

  Future<bool> addFavorite(Entity entity) async {
    return await _addFavoriteCharacter(entity);
  }
}

class FavoriteCharactersListProvider extends StateNotifier<List<CharacterEntity>> {
FavoriteCharactersListProvider() : super([]);
}

class FilmsProvider extends ChangeNotifier {
  final IAddFavoriteFilmUsecase _addFavoriteFilm;

  FilmsProvider(this._addFavoriteFilm);

  Future<bool> addFavorite(Entity entity) async {
    return await _addFavoriteFilm(entity);
  }
}
