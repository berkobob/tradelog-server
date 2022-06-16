import 'dart:async';

import 'package:alfred/alfred.dart';
import 'package:dcli/dcli.dart';

import 'routes/dividend_route.dart';
import 'routes/portfolio_route.dart';
import 'routes/position_route.dart';
import 'routes/stock_route.dart';
import 'routes/trade_route.dart';
import '../constants.dart' as k;

class Server {
  final app = Alfred(logLevel: LogType.info);
  int port;

  Server({this.port = k.port}) {
    app.onNotFound = notFoundHandler;
    app.onInternalError = internalErrorHandler;
    app.all('*', cors(origin: '*'));

    TradeRoute(app.route('trades'));
    PositionRoute(app.route('positions'));
    StockRoute(app.route('stocks'));
    PortfolioRoute(app.route('portfolios'));
    DividendRoute(app.route('dividends'));

    app.get('/', (req, res) => {'ok': true});
  }

  Future<Server> start() async {
    await app.listen(port);
    print('${DateTime.now()} - ${yellow('info')} '
        '- listening on port ${green('$port', bold: true)}');
    return this;
  }

  Future<void> close() async => await app.close();

  FutureOr notFoundHandler(HttpRequest request, HttpResponse response) =>
      {'ok': false, 'msg': 'Not found'};

  FutureOr internalErrorHandler(HttpRequest request, HttpResponse response) =>
      {'ok': false, 'msg': 'Internal error'};
}
