import 'package:alfred/alfred.dart';

import '../../models/stock.dart';
import '../reply.dart';
import 'base_route.dart';

class StockRoute extends BaseRoute {
  StockRoute(super.route);

  @override
  Future<Reply> get(HttpRequest request, HttpResponse response) async => Reply(
      msg: (await Stock.find({})).map((stock) => stock.response).toList());
}
