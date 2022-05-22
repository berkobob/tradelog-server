import 'package:alfred/alfred.dart';

import '../../models/position.dart';
import '../reply.dart';
import 'base_route.dart';

class PositionRoute extends BaseRoute {
  PositionRoute(super.route);

  @override
  Future<Reply> get(HttpRequest request, HttpResponse response) async => Reply(
      msg: (await Position.find({}))
          .map((position) => position.response)
          .toList());
}
