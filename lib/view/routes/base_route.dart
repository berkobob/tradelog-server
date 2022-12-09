import 'package:alfred/alfred.dart';

typedef Json = Map<String, dynamic>;

abstract class BaseRoute {
  final NestedRoute _route;

  BaseRoute(this._route) {
    _route.get('/', get);
    _route.post('/', post);
  }

  Future<Json> get(HttpRequest request, HttpResponse response);
  Future<Json> post(HttpRequest request, HttpResponse response) async =>
      await Future.value({'msg': 'No posting'});

  Json query(Map<String, List<String>> parms) {
    final query = <String, dynamic>{};
    parms.forEach((key, value) {
      final val = value.join();
      if (val.isNotEmpty) {
        if (val[0] == '<') {
          query[key] = {r'$lt': num.parse(val.substring(1))};
        } else if (val[0] == '>') {
          query[key] = {r'$gt': num.parse(val.substring(1))};
        } else {
          query[key] = num.tryParse(val) ?? val;
        }
      }
    });
    return query;
  }
}
