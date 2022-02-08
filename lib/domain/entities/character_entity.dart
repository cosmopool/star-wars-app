class CharacterEntity {
  late final String name;
  late final double height;
  late final double mass;
  late final String hairColor;
  late final String skinColor;
  late final String eyeColor;
  late final String birthYear;
  late final String gender;
  String _homeworld = "";
  late final String homeworldUrl;
  late final List<String> films;
  late final List<dynamic> species;
  late final String url;

  CharacterEntity(
    this.name,
    this.height,
    this.mass,
    this.hairColor,
    this.skinColor,
    this.eyeColor,
    this.birthYear,
    this.gender,
    this._homeworld,
    this.films,
    this.species,
    this.url,
  );

  // TODO: make it more readable
  // this constructor is sooo ugly
  CharacterEntity.fromMap(Map character) {
    name = character['name'] as String;
    films = character['films'] as List<String>;
    url = character['url'] as String;

    (character['hairColor'] != null) ? character['hairColor'] as String : hairColor = "n/a";
    (character['skinColor'] != null) ? skinColor = character['skinColor'] as String : skinColor = "n/a";
    (character['eyeColor'] != null) ? character['eyeColor'] as String : eyeColor = "n/a";
    (character['birthYear'] != null) ? birthYear = character['birthYear'] as String : birthYear = "n/a";
    (character['gender'] != null) ? gender = character['gender'] as String : gender = "n/a";

    if (character['homeworld'] != null)  {
      homeworldUrl = character['homeworld'] as String;
    } else {
      _homeworld = "n/a";
      homeworldUrl = "n/a";
    }

    final _species = character['species'];
    (_species == null || _species == []) ? species = character['species'] as List<dynamic> : species = ["n/a"];

    final _height = character['height'] as String;
    height = double.parse(_height);
    final _mass = character['mass'] as String;
    mass = double.parse(_mass);
  }

  String get homeworld => _homeworld;

  // return true if was able to set homeworld name
  // return false if homeworld name was already set
  bool setHomeworld(String name) {
    if (_homeworld == "") {
      _homeworld = name;
      return true;
    } else {
      return false;
    }
  }
}
