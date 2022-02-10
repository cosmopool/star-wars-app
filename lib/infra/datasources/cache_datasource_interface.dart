abstract class ICacheDatasource {
  Future<int> add(String table, Map entry);
  Future<int> remove(String table, int id);
  Future<List<Map>> fetch(String table);
}
