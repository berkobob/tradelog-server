import 'dart:io';

import 'package:dcli/dcli.dart';
import 'package:server/server.dart';

void main(List<String> args) {
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
}
