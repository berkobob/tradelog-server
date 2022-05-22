import 'dart:io';

import 'package:dcli/dcli.dart';
import 'package:get_it/get_it.dart';

import 'controllers/log_controller.dart';
import 'services/database_service.dart';
import 'view/server.dart';

void init({int? port, database, url}) async {
  // Model
  GetIt.I.registerSingletonAsync<DatabaseService>(
      () async => await DatabaseService(url: url, database: database).open());

  // View
  GetIt.I.registerSingletonAsync<Server>(() async =>
      port != null ? await Server(port: port).start() : await Server().start());

  // Controller
  GetIt.I.registerSingleton<LogController>(LogController());
}

void main(List<String> args) async {
  print('${DateTime.now()} - ${red('WARN')} - Running in development mode. '
      'This will drop the database');
  var parser = ArgParser();
  parser.addOption('port', abbr: 'p');
  parser.addOption('database', abbr: 'd');
  parser.addOption('url', abbr: 'u');
  final settings = parser.parse(args);

  final int? port =
      int.tryParse(settings['port'] ?? Platform.environment['port'] ?? '');
  final String? database = settings['database'];
  final String? url = settings['url'];

  init(port: port, database: database, url: url);

  // for dev
  await GetIt.I.isReady<DatabaseService>();
  await GetIt.I.get<DatabaseService>().drop();
  print('${DateTime.now()} - ${red('WARN')} - Database dropped.');
}
