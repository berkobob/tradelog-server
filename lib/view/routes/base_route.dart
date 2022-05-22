import 'package:alfred/alfred.dart';
import 'package:get_it/get_it.dart';

import '../../controllers/log_controller.dart';
import '../reply.dart';

export '../../constants.dart';

abstract class BaseRoute {
  final NestedRoute _route;
  final logController = GetIt.I.get<LogController>();

  BaseRoute(this._route) {
    _route.get('/', get);
    _route.post('/', post);
  }

  Future<Reply> get(HttpRequest request, HttpResponse response);
  Future<Reply> post(HttpRequest request, HttpResponse response) async =>
      await Future.value(Reply(msg: 'No posting', statusCode: 401));
}
