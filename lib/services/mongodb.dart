import 'dart:io';

import 'package:dcli/dcli.dart';
import 'package:mongo_dart/mongo_dart.dart';
export 'package:mongo_dart/mongo_dart.dart' show ObjectId;

import 'database_service.dart';

class MongoDB implements DatabaseService {
  late Db db;
  late String url;
  late String database;

  MongoDB({url, database}) {
    this.url = url ?? Platform.environment['databaseUrl'] ?? databaseUrl;
    this.database =
        database ?? Platform.environment['databaseName'] ?? databaseName;
  }

  @override
  Future<DatabaseService> open() async {
    print('${DateTime.now()} - ${yellow('info')} '
        '- Attempting to connect to: ${green('$url$database', bold: true)}');
    db = await Db.create(url + database);
    try {
      await db.open();
      print('${DateTime.now()} - ${yellow('info')} - Successfully connected to'
          ' database: ${green(db.databaseName!, bold: true)}.');
    } catch (e) {
      print('${DateTime.now()} - ${red('ERR!')} - '
          '${red('failed to connect to $url', bold: true)}');
      rethrow;
    }
    return this;
  }

  @override
  Future close() async {
    db.close();
  }

  @override
  bool isConnected() => db.isConnected;

  @override
  Future<ObjectId> save(String collection, Json data) async {
    final coll = db.collection(collection);
    final result = await coll.insertOne(data);
    if (result.success == true) return result.id;
    throw 'Failed to save $data in $collection';
  }

  @override
  Future<Json?> findOne(String collection, Json query) async {
    final coll = db.collection(collection);
    return await coll.findOne(query);
  }

  @override
  Future<List<Json>> find(String collection, Json query) async {
    final coll = db.collection(collection);
    return await coll.find(query).toList();
  }

  @override
  Future<void> delete(String collection, dynamic id) async {
    final coll = db.collection(collection);
    final result = await coll.remove({'_id': id});
    if (result['n'] != 1) throw 'Failed to delete $id from $collection';
  }

  @override
  Future<void> update(String collection, dynamic id, Json query) async {
    final coll = db.collection(collection);
    final result = await coll.updateOne({'_id': id}, {r'$set': query});
    if (result.success) return;
    throw 'Failed to update $id with $query in $collection';
  }

  @override
  Future<Json?> findById(String collection, id) async {
    final coll = db.collection(collection);
    return await coll.findOne({'_id': id});
  }

  @override
  Future<DatabaseService> drop([String? collection]) async {
    if (collection == null) {
      await db.drop();
    } else {
      await db.dropCollection(collection);
    }
    return this;
  }
}
