import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:mongo_dart/mongo_dart.dart';

import 'database_service.dart';

class MongoDB implements DatabaseService {
  final log = Logger();

  late Db db;
  final String _url;
  final String _database;

  MongoDB({url, database})
      : _url = url ?? 'mongodb://localhost:27017/',
        _database = database ?? 'production';

  @override
  Future<DatabaseService> open() async {
    log.i('${DateTime.now()} - Attempting to connect to: $_url$_database');
    db = await Db.create(_url + _database);
    try {
      await db.open();
      log.i(
          '${DateTime.now()} - Successfully connected to database: ${db.databaseName}.');
    } catch (e) {
      log.i('${DateTime.now()} - failed to connect to $_url');
      rethrow;
    }
    return this;
  }

  @override
  Future close() async {
    await db.close();
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
    if (query.keys.contains('closed')) {
      if (query.keys.contains('month')) {
        query['closed'] = {
          r'$gte': DateTime(query['closed'], query['month']),
          r'$lt': DateTime(query['closed'], query['month'] + 1),
        };
        query.remove('month');
      } else {
        query['closed'] = {
          r'$gte': DateTime(query['closed']),
          r'$lt': DateTime(query['closed'] + 1),
        };
      }
      if (collection == 'dividends') {
        query['date'] = query['closed'];
        query.remove('closed');
      }
    }

    final coll = db.collection(collection);
    return await coll.find(query).toList();
  }

  @override
  Future<void> delete(String collection, covariant ObjectId id) async {
    final coll = db.collection(collection);
    final result = await coll.remove({'_id': id});
    if (result['n'] != 1) throw 'Failed to delete $id from $collection';
  }

  @override
  Future<void> update(
      String collection, covariant ObjectId id, Json query) async {
    final coll = db.collection(collection);
    final result = await coll.updateOne({'_id': id}, {r'$set': query});
    if (result.success) return;
    throw 'Failed to update $id with $query in $collection';
  }

  @override
  Future<Json?> findById(String collection, covariant ObjectId id) async {
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
