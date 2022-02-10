import 'entity.dart';

class FilmEntity implements Entity {
  late final String _title;
  late final String _url;
  late final int _id;
  late final bool _favorite;

  FilmEntity(
    this._title,
    this._url,
    this._id,
    this._favorite,
  );

  FilmEntity.fromMap(Map film) {
    _title = film['title'] as String;
    _url = film['url'] as String;
    final _urlToList = _url.split('/');
    _id = int.parse(_urlToList[_urlToList.length - 2]);
    (film['favorite'] != null) ? _favorite = film['favorite'] : _favorite = false;
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'name': _title,
      'url': _url,
      'id': _id,
      'favorite': _favorite
    };
  }

  @override
  String toString() => 'films';

  @override
  String get name => _title;

  @override
  String get url => _url;

  @override
  int get id => _id;

  @override
  bool get favorite => _favorite;
}
