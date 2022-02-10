import 'entity.dart';

class CharacterEntity implements Entity {
  late final String name;
  late final String url;
  late final int id;

  CharacterEntity(
    this.name,
    this.url,
    this.id,
  );

  CharacterEntity.fromMap(Map character) {
    name = character['name'] as String;
    url = character['url'] as String;
    final _urlToList = url.split('/');
    id = int.parse(_urlToList[_urlToList.length - 2]);
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'url': url,
      'id' : id,
    };
  }

  @override
  String toString() => 'characters';
}
