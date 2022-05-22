import 'package:server/services/database_service.dart';
import 'package:test/test.dart';

final db = DatabaseService(database: "testdb");
final coll = 'test';

main() async {
  setUp(() async {
    await db.open();
    await db.drop(coll);
  });

  tearDown(() async => db.close());

  test('Save a document to the database', () async {
    final result = await db.save(coll, {'anInt': 1, 'aString': 'Antoine'});
    expect(result, isA<ObjectId>());
  });

  test('Find one document', () async {
    final result = await db.save(coll, {'anInt': 1, 'aString': 'Antoine'});
    final r = await db.findOne(coll, {'_id': result});
    expect(r, isNotNull);
  });

  test('Replace a field in a document', () async {
    final result = await db.save(coll, {'anInt': 1, 'aString': 'Antoine'});
    final result1 = await db.findOne(coll, {'_id': result});
    await db.update(coll, result, {'aString': 'Lever'});
    final result2 = await db.findOne(coll, {'_id': result});
    expect(result1?['aString'] != result2?['aString'], isTrue);
  });

  test('Insert a document into database', () {
    final string = 'Antoine';
    expect(string, equals('Antoine'));
  });

  test('Find all matching documents', () async {
    await db.save(coll, {'anInt': 1, 'aString': 'All'});
    await db.save(coll, {'anInt': 1, 'aString': 'random'});
    await db.save(coll, {'anInt': 1, 'aString': 'words'});
    await db.save(coll, {'anInt': 2, 'aString': 'Antoine'});
    final results = await db.find(coll, {'anInt': 1});
    expect(results.length, equals(3));
  });

  test('Delete a document from the datbase', () async {
    await db.save(coll, {'anInt': 1, 'aString': 'All'});
    await db.save(coll, {'anInt': 1, 'aString': 'random'});
    await db.save(coll, {'anInt': 1, 'aString': 'words'});
    await db.save(coll, {'anInt': 2, 'aString': 'Antoine'});
    final doc = await db.findOne(coll, {'anInt': 2});
    db.delete(coll, doc?['_id'] as ObjectId);
    final results = await db.find(coll, {});
    expect(results.length, equals(3));
  });

  test('Find a record by its ID', () async {
    final id = await db.save(coll, {'anInt': 3, 'aString': 'All'});
    final result = await db.findById(coll, id);
    expect(result, isNotNull);
    expect(result?['anInt'], equals(3));
  });
}
