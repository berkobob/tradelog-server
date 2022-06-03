import 'package:alfred/alfred.dart';

import '../../models/portfolio.dart';
import 'base_route.dart';

class PortfolioRoute extends BaseRoute {
  PortfolioRoute(super.route);

  @override
  Future<Json> get(HttpRequest request, HttpResponse response) async => {
        'portfolios':
            (await Portfolio.find(query(request.uri.queryParametersAll)))
                .map((portfolio) => portfolio.response)
                .toList()
      };
}
