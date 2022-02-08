import 'entity.dart';
import 'character_entity.dart';

class FilmEntity implements Entity {
  late final String title;
  late final int episodeId;
  late final int id;
  late final String openingCrawl;
  late final String director;
  late final String producer;
  late final DateTime releaseDate;
  List<CharacterEntity> _characters = [];
  late List<String> charactersUrl;
  // late Map _charactersMap = {};
  late final String _url;

  FilmEntity(
    this.title,
    this.episodeId,
    this.id,
    this.openingCrawl,
    this.director,
    this.producer,
    this.releaseDate,
    this._characters,
    this._url,
  );

  FilmEntity.fromMap(Map film) {
    title = film['title'] as String;
    episodeId = film['episode_id'] as int;
    openingCrawl = film['opening_crawl'] as String;
    director = film['director'] as String;
    producer = film['producer'] as String;
    releaseDate = DateTime.parse(film['release_date']);
    charactersUrl = film['characters'] as List<String>;
    _url = film['url'] as String;
    final _urlToList = _url.split('/');
    id = int.parse(_urlToList[_urlToList.length - 2]);
  }

  List<CharacterEntity> get characters => _characters;

  // TODO: write better character list fetch
  // film repository will fetch all characters from list
  // and send here so we can display
  bool setCharacterEntityList(List<CharacterEntity> charList) {
    final listLen = charList.length;
    final _listLen = charactersUrl.length;
    if (_characters == [] && listLen == _listLen) {
      _characters = charList;
      return true;
    } else {
      return false;
    }
  }
}
