// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:server/controllers/log_controller.dart';
import 'package:server/services/database_service.dart';
import 'package:server/view/server.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

main() {
  // Server server = Server()..start();

  setUpAll(() async {
    GetIt.I.registerSingletonAsync<DatabaseService>(
        () async => await DatabaseService(database: "testdb").open());
    GetIt.I.registerSingletonAsync<Server>(() async => await Server().start());
    GetIt.I.registerSingleton<LogController>(LogController());
    await GetIt.I.allReady();
  });

  tearDownAll(() async => await GetIt.I.get<Server>().close());

  test('Expect the server to be up and running', () async {
    final url = Uri.parse('http://localhost:3000/');
    final result = await http.get(url);
    expect(result, isA<http.Response>());
    expect(result.statusCode, equals(200));
  });

  test('Expect trades from GET /trades', () async {
    final url = Uri.http('localhost:3000', '/trades');
    final result = await http.get(url);
    expect(result.statusCode, equals(200));
    final trades = json.decode(result.body);
    expect(trades, isA<Map>());
  });

  test('Expect positions from GET /positions', () async {
    final url = Uri.http('localhost:3000', '/positions');
    final result = await http.get(url);
    expect(result.statusCode, equals(200));
    final positions = json.decode(result.body);
    expect(positions, isA<Map>());
  });

  test('Expect stocks from GET /stocks', () async {
    final url = Uri.http('localhost:3000', '/stocks');
    final result = await http.get(url);
    expect(result.statusCode, equals(200));
    final stocks = json.decode(result.body);
    expect(stocks, isA<Map>());
  });

  test('Expect portfolios from GET /portfolios', () async {
    final url = Uri.http('localhost:3000', '/portfolios');
    final result = await http.get(url);
    expect(result.statusCode, equals(200));
    final portfolios = json.decode(result.body);
    expect(portfolios, isA<Map>());
  });
}
