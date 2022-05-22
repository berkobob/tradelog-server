import 'dart:async';
import 'dart:io';

import 'package:alfred/alfred.dart';
import 'package:dcli/dcli.dart';

import 'reply.dart';
import 'routes/portfolio_route.dart';
import 'routes/position_route.dart';
import 'routes/stock_route.dart';
import 'routes/trade_route.dart';
import '../constants.dart' as k;

class Server {
  final app = Alfred(logLevel: LogType.warn);
  int port;

  Server({this.port = k.port}) {
    app.onNotFound = notFoundHandler;
    app.onInternalError = internalErrorHandler;
    app.typeHandlers.add(replyTypeHander());

    TradeRoute(app.route('trades'));
    PositionRoute(app.route('positions'));
    StockRoute(app.route('stocks'));
    PortfolioRoute(app.route('portfolios'));

    app.get(
        '/', (req, res) => Reply(msg: 'Trade Log Server up and running...'));
  }

  Future<Server> start() async {
    await app.listen(port);
    print('${DateTime.now()} - ${yellow('info')} '
        '- listening on port ${green('$port', bold: true)}');
    return this;
  }

  Future<void> close() async => await app.close();

  FutureOr notFoundHandler(HttpRequest request, HttpResponse response) =>
      Reply(ok: false, msg: 'Not found', statusCode: 404);

  FutureOr internalErrorHandler(HttpRequest request, HttpResponse response) =>
      Reply(ok: false, msg: 'Internal error', statusCode: 500);

  TypeHandler<dynamic> replyTypeHander() =>
      TypeHandler<Reply>((req, res, Reply reply) async {
        res.statusCode = reply.statusCode;
        res.headers.contentType = ContentType.json;
        res.json(reply.response);
        await res.close();
      });
}
