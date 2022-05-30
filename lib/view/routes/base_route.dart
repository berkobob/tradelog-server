import 'package:alfred/alfred.dart';
import 'package:get_it/get_it.dart';

import '../../controllers/log_controller.dart';

import '../../constants.dart';
export '../../constants.dart';

abstract class BaseRoute {
  final NestedRoute _route;
  final logController = GetIt.I.get<LogController>();

  BaseRoute(this._route) {
    _route.get('/', get);
    _route.post('/', post);
  }

  Future<Json> get(HttpRequest request, HttpResponse response);
  Future<Json> post(HttpRequest request, HttpResponse response) async =>
      await Future.value({'msg': 'No posting'});

  Json query(Map<String, List<String>> parms) {
    final query = <String, dynamic>{};
    parms.forEach((key, value) => value.join().isNotEmpty
        ? query[key] = num.tryParse(value.join()) ?? value.join()
        : null);
    return query;
  }
}
