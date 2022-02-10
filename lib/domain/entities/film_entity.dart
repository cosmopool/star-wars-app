import 'entity.dart';

class FilmEntity implements Entity {
  late final String title;
  late final String url;
  late final int id;

  FilmEntity(
    this.title,
    this.url,
    this.id,
  );

  FilmEntity.fromMap(Map film) {
    title = film['title'] as String;
    url = film['url'] as String;
    final _urlToList = url.split('/');
    id = int.parse(_urlToList[_urlToList.length - 2]);
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'url': url,
      'id': id,
    };
  }

  @override
  String toString() => 'films';
}
