import 'package:alfred/alfred.dart';
import 'package:server/models/dividend.dart';
import 'package:server/view/routes/base_route.dart';

class DividendRoute extends BaseRoute {
  final Function dividend;
  DividendRoute(super.route, {required this.dividend});

  @override
  Future<Json> get(HttpRequest request, HttpResponse response) async => {
        'dividends':
            (await Dividend.find(query(request.uri.queryParametersAll)))
                .map((divi) => divi.response)
                .toList()
      };

  @override
  Future<Json> post(HttpRequest request, HttpResponse response) async =>
      dividend(await request.body as Json);
}
