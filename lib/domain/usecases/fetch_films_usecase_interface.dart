import '../entities/film_entity.dart';

abstract class IFetchFilmsUsecase {
  List<FilmEntity> call();
}
