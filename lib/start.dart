import 'package:get_it/get_it.dart';
import 'package:server/services/mongodb.dart';

import 'controllers/controller.dart';
import 'services/database_service.dart';
import 'view/view.dart';

class Start {
  int? port;
  String? database;
  String? url;

  Start({this.port, this.database, this.url}) {
    GetIt.I.registerSingletonAsync<DatabaseService>(
        () async => await MongoDB(url: url, database: database).open());
    View(port: port, controller: Controller());
  }
}
