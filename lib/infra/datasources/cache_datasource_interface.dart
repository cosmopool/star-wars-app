abstract class ICacheDatasource {
  Future<bool> add(String table, Map entry);
  Future<bool> remove(String table, int id);
  Future<List<Map>> fetch(String table);
}
