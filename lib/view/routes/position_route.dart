import 'package:alfred/alfred.dart';

import '../../models/position.dart';
import 'base_route.dart';

class PositionRoute extends BaseRoute {
  PositionRoute(super.route);

  @override
  Future<Json> get(HttpRequest request, HttpResponse response) async => {
        'positions':
            (await Position.find(query(request.uri.queryParametersAll)))
                .map((position) => position.response)
                .toList()
      };
}
