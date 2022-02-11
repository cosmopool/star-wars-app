import 'package:mobx/mobx.dart';
import 'package:star_wars_app/domain/usecases/add_favorite_film_usecase_interface.dart';
import 'package:star_wars_app/domain/usecases/fetch_films_usecase_interface.dart';
part 'entities_store.g.dart';

class EntityStore = _EntityStore with _$EntityStore;

abstract class _EntityStore with Store {
  final IAddFavoriteFilmUsecase _addUsecase;
  final IFetchFilmsUsecase _fetchUsecase;

  _EntityStore(this._addUsecase, this._fetchUsecase);

  @observable
  var filmList = ObservableList();

  @action
  void fetchFilms() async {
    filmList = await _fetchUsecase();
  }
}
