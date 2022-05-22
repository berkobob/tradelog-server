import 'package:alfred/alfred.dart';

import '../../models/trade.dart';
import '../reply.dart';
import 'base_route.dart';

class TradeRoute extends BaseRoute {
  TradeRoute(super.route);

  @override
  Future<Reply> get(HttpRequest request, HttpResponse response) async => Reply(
      msg: (await Trade.find({})).map((trade) => trade.response).toList());

  @override
  Future<Reply> post(HttpRequest request, HttpResponse response) async {
    final body = await request.body as Json;
    final response = await logController.trade(body);
    return Reply(ok: response.keys.contains('trade'), msg: response);
  }
}
