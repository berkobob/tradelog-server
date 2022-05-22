import 'mongodb.dart';
import '../constants.dart';
export '../constants.dart';
export 'mongodb.dart' show ObjectId;

abstract class DatabaseService {
  factory DatabaseService({url, database}) {
    return MongoDB(url: url, database: database);
  }
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
