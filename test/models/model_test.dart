import 'package:get_it/get_it.dart';
import 'package:server/services/database_service.dart';
import 'package:test/test.dart';

import 'test.dart';

main() async {
  late DatabaseService db;
  setUpAll(() async {
    GetIt.I.registerSingletonAsync<DatabaseService>(
        () async => await DatabaseService(database: "testdb").open());
    await GetIt.I.allReady();
    db = GetIt.I.get<DatabaseService>();
  });

  test('Create a new model from scratch', () {
    final result = Test(anInt: 0, aString: 'Create test');
    expect(result, isA<Test>());
    expect(result.id, isNull);
  });

  test('Create a new model from Json', () {
    final test = Test.fromJson({'anInt': 1, 'aString': 'From Json'});
    expect(test, isA<Test>());
  });

  test('Model creates correct collection name', () {
    final test = Test(anInt: 2, aString: 'Test collection name');
    expect(test.collection, equals('tests'));
  });

  test('Model returns correct Json', () {
    final test = Test(anInt: 3, aString: 'Test Json');
    expect(test.toJson()['anInt'], equals(3));
    expect(test.toJson()['aString'], equals('Test Json'));
  });

  test('Save a model to the database', () async {
    final test = Test(anInt: 4, aString: 'Create test');
    await test.save();
    final result = await db.findById('tests', test.id);
    expect(result, isNotNull);
  });

  test('Delete a document from the database', () async {
    final test = Test(anInt: 5, aString: 'Delete test');
    await test.save().then((test) => test.delete());
    // await test.delete();
    final result = await db.findById('tests', test.id);
    expect(result, isNull);
  });

  test('Update a record in the database', () async {
    final test = Test(anInt: 6, aString: 'Update test');
    await test.save();
    test.aString = 'A new string';
    test.save();
    final result = await db.findById('tests', test.id);
    expect(result?['aString'], equals('A new string'));
    expect(test.aString, equals('A new string'));
  });

  test('Find a model by ID', () async {
    final test = Test(anInt: 7, aString: 'Find by ID test');
    await test.save();
    final result = await Test.findById(test.id);
    expect(result, isA<Test>());
    expect(result?.anInt, equals(7));
  });

  test('Find many records', () async {
    Test(anInt: 8, aString: 'Find by many test1').save();
    Test(anInt: 8, aString: 'Find by many test2').save();
    Test(anInt: 8, aString: 'Find by many test3').save();
    final result = await Test.find({'anInt': 8});
    expect(result, isA<List>());
    expect(result.length > 1, isTrue);
  });
}
