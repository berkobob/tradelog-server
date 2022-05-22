import 'package:alfred/alfred.dart';

import '../../models/portfolio.dart';
import '../reply.dart';
import 'base_route.dart';

class PortfolioRoute extends BaseRoute {
  PortfolioRoute(super.route);

  @override
  Future<Reply> get(HttpRequest request, HttpResponse response) async => Reply(
      msg: (await Portfolio.find({}))
          .map((portfolio) => portfolio.response)
          .toList());
}
