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
    name = map['name'] as String;
    :rl = map['url'] as String;
    p
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
