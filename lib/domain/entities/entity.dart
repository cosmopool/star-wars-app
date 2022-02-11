import 'package:star_wars_app/core/enums.dart';

class Entity {
  late final String name;
  late final String url;
  late final int id;
  late final EntityType type;
  late final bool isFavorite;

  Entity(
    this.name,
    this.url,
    this.id,
    this.type,
    this.isFavorite,
  );

  Entity.fromMap(Map map) {
    name = (map['name'] != null) ? map['name'] : map['title'];
    isFavorite = (map['isFavorite'] != null) ? map['isFavorite'] : false;
    url = map['url'] as String;
    type = convertUrlToType(map['url']);

    final _urlToList = url.split('/');
    final _id = int.parse(_urlToList[_urlToList.length - 2]);

    // all characters will have id greater then 1000
    // this will end conflic on add or remove entries from database
    if (type == EntityType.character) {
      id = _id + 1000;
    } else {
      id = _id;
    }
  }

  static EntityType convertUrlToType(String url) {
    final isFilm = url.contains('/film');
    return isFilm ? EntityType.film : EntityType.character;
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'url': url,
      'id': id,
      'type': typeToString(),
      'isFavorite': isFavorite,
    };
  }

  String typeToString() => type == EntityType.film ? 'film' : 'character';
}
