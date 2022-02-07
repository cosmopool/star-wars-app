class Film {
  late final String title;
  late final int episodeId;
  late final int id;
  late final String openingCrawl;
  late final String director;
  late final String producer;
  late final DateTime releaseDate;
  late final List<String> characters;
  late final String _url;

  Film(
    this.title,
    this.episodeId,
    this.id,
    this.openingCrawl,
    this.director,
    this.producer,
    this.releaseDate,
    this.characters,
    this._url,
  );

  Film.fromMap(Map film) {
    title = film['title'] as String;
    episodeId = film['episodeId'] as int;
    id = film['id'] as int;
    openingCrawl = film['openingCrawl'] as String;
    director = film['director'] as String;
    producer = film['producer'] as String;
    releaseDate = film['releaseDate'] as DateTime;
    characters = film['characters'] as List<String>;
  }
}
