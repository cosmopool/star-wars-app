import 'package:star_wars_app/core/response.dart';

abstract class ICacheDatasource {
  Future<Response> add(String table, Map entry);
  Future<Response> remove(String table, int id);
  Future<Response> show(String table);
}
