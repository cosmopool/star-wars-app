import 'package:get_it/get_it.dart';
import 'package:star_wars_app/data/datasource/api_datasource.dart';
import 'package:star_wars_app/data/datasource/sqlite_database_manager.dart';
import 'package:star_wars_app/data/datasource/sqllite_datasource.dart';
import 'package:star_wars_app/domain/repositories/favorites_repository_interface.dart';
import 'package:star_wars_app/domain/repositories/fetch_characters_repository_interface.dart';
import 'package:star_wars_app/domain/repositories/fetch_films_repository_interface.dart';
import 'package:star_wars_app/domain/usecases/add_favorite_character_usecase_interface.dart';
import 'package:star_wars_app/domain/usecases/add_favorite_film_usecase_interface.dart';
import 'package:star_wars_app/domain/usecases/fetch_characters_usecase_interface.dart';
import 'package:star_wars_app/domain/usecases/fetch_films_usecase_interface.dart';
import 'package:star_wars_app/domain/usecases/remove_favorite_film_usecase_interface.dart';
import 'package:star_wars_app/domain/usecases/show_favorites_usecase.dart';
import 'package:star_wars_app/infra/datasources/api_datasource_interface.dart';
import 'package:star_wars_app/infra/datasources/cache_datasource_interface.dart';
import 'package:star_wars_app/infra/repositories/favorites_repository.dart';
import 'package:star_wars_app/infra/repositories/fetch_characters_repository.dart';
import 'package:star_wars_app/infra/repositories/fetch_films_repository.dart';
import 'package:star_wars_app/ui/providers/entities_provider_riverpod.dart';

class Inject {
  static init() async {
    GetIt getIt = GetIt.instance;


    // datasource
    // database
    final _path = await SqliteDatabaseManager.getDatabasePath('starwars');
    final _database = await SqliteDatabaseManager.openOrCreateDatabase(_path);
    getIt.registerLazySingleton(() => _database);
    // api
    getIt.registerLazySingleton<ICacheDatasource>(() => SqliteDatasource(getIt()));
    getIt.registerLazySingleton<IApiDatasource>(() => ApiDatasource());

    // repositories
    getIt.registerLazySingleton<IFavoritesRespository>(() => FavoritesRepository(getIt()));
    getIt.registerLazySingleton<IFetchFilmsRespository>(() => FetchFilmsRepository(getIt(), getIt()));
    getIt.registerLazySingleton<IFetchCharactersRespository>(() => FetchCharactersRepository(getIt(), getIt()));

    // usecases
    getIt.registerLazySingleton<FetchFilmsUsecase>(() => FetchFilmsUsecase(getIt()));
    getIt.registerLazySingleton<FetchCharactersUsecase>(() => FetchCharactersUsecase(getIt()));
    getIt.registerLazySingleton<IAddFavoriteFilmUsecase>(() => AddFavoriteFilmUsecase(getIt()));
    getIt.registerLazySingleton<AddFavoriteCharacterUsecase>(() => AddFavoriteCharacterUsecase(getIt()));
    getIt.registerLazySingleton<RemoveFavoriteFilmUsecase>(() => RemoveFavoriteFilmUsecase(getIt()));
    getIt.registerLazySingleton<ShowFavoritesUsecase>(() => ShowFavoritesUsecase(getIt()));

    // providers
    // getIt.registerLazySingleton<EntitiesProvider>(() => EntitiesProvider(getIt()));
    getIt.registerLazySingleton<FilmsProvider>(() => FilmsProvider(getIt()));
  }
  static injectProvider() {
    // final 
    // final _filmsProvider = FilmsProvider(_addFavoriteFilm);
  }
}
