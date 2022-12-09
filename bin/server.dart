import 'dart:io';

import 'package:args/args.dart';
import 'package:logger/logger.dart';
import 'package:server/start.dart';
import 'package:yaml/yaml.dart';

void main(List<String> arguments) async {
  final log = Logger()..registerPrinter(printer);

  var parser = ArgParser();
  parser.addOption('port', abbr: 'p', help: 'The Server port number');
  parser.addOption('database', abbr: 'd', help: 'The database name');
  parser.addOption('url', abbr: 'u', help: 'The database address');
  parser.addFlag('help', abbr: 'h', help: 'Displays this help message');
  parser.addOption('config', abbr: 'c', help: 'Path to the config.yaml file');
  final args = parser.parse(arguments);

  if (args['help']) {
    print(parser.usage);
    return;
  }

  Map? yaml;
  final file = File(args['config'] ?? 'config.yaml');
  if (await file.exists()) yaml = loadYaml(await file.readAsString());

  final int? port =
      int.tryParse(args['port'] ?? Platform.environment['port'] ?? '') ??
          yaml?['port'];

  final String? database = args['database'] ??
      Platform.environment['databaseName'] ??
      yaml?['databaseName'];

  final String? url = args['url'] ??
      Platform.environment['databaseUrl'] ??
      yaml?['databaseUrl'];

  log.v(
      'Preparing to start server with port: $port, database: $database and url: $url');

  Start(port: port, database: database, url: url);
}
