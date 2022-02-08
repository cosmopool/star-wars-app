import 'character.dart';

class Film {
  late final String title;
  late final int episodeId;
  late final int id;
  late final String openingCrawl;
  late final String director;
  late final String producer;
  late final DateTime releaseDate;
  List<Character> _characters = [];
  late List<String> charactersUrl;
  // late Map _charactersMap = {};
  late final String _url;

  Film(
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

  Film.fromMap(Map film) {
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

  List<Character> get characters => _characters;
  }
}
