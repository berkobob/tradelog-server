import 'package:alfred/alfred.dart';
import 'package:server/models/trade.dart';

import 'base_route.dart';

class TradeRoute extends BaseRoute {
  Function trade;
  TradeRoute(super.route, {required this.trade});

  @override
  Future<Json> get(HttpRequest request, HttpResponse response) async => {
        'trades': (await Trade.find(query(request.uri.queryParametersAll)))
            .map((trade) => trade.response)
            .toList()
      };

  @override
  Future<Json> post(HttpRequest request, HttpResponse response) async {
    final body = await request.body as Json;
    final response = await trade(body);
    return {'ok': response.keys.contains('trade'), 'msg': response};
  }
}
