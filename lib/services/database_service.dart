typedef Json = Map<String, dynamic>;

abstract class DatabaseService {
  DatabaseService({database, url});
  Future<DatabaseService> open();
  Future close();
  bool isConnected();
  Future<dynamic> save(String collection, Json data);
  Future<Json?> findOne(String collection, Json query);
  Future<List<Json>> find(String collection, Json query);
  Future<Json?> findById(String collection, dynamic id);
  Future<void> delete(String collection, dynamic id);
  Future<void> update(String collection, dynamic id, Json data);
  Future<DatabaseService> drop([String? collection]);
}
