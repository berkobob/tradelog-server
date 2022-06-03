import 'package:alfred/alfred.dart';

import '../../models/stock.dart';
import 'base_route.dart';

class StockRoute extends BaseRoute {
  StockRoute(super.route);

  @override
  Future<Json> get(HttpRequest request, HttpResponse response) async => {
        'stocks': (await Stock.find(query(request.uri.queryParametersAll)))
            .map((stock) => stock.response)
            .toList()
      };
}
