abstract class Entity {
  Map<String, dynamic> toMap();
  String get name;
  int get id;
  String get url;
  bool get favorite;
  // int get type;
}
