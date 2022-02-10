import 'entity.dart';

class CharacterEntity implements Entity {
  late final String _name;
  late final String _url;
  late final int _id;
  late final bool _favorite;

  CharacterEntity(
    this._name,
    this._url,
    this._id,
    this._favorite,
  );

  CharacterEntity.fromMap(Map character) {
    _name = character['name'] as String;
    _url = character['url'] as String;
    final _urlToList = _url.split('/');
    _id = int.parse(_urlToList[_urlToList.length - 2]);
    (character['favorite'] != null) ? _favorite = character['favorite'] : _favorite = false;
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'name': _name,
      'url': _url,
      'id' : _id,
      'favorite': _favorite
    };
  }

  @override
  String toString() => 'characters';

  @override
  String get name => _name;

  @override
  String get url => _url;

  @override
  int get id => _id;

  @override
  bool get favorite => _favorite;
}
