import 'dart:async';

import 'package:alfred/alfred.dart';
import 'package:logger/logger.dart';

import '../controllers/controller.dart';
import 'routes/routes.dart';

class View {
  final app = Alfred(logLevel: LogType.info);
  final Controller controller;
  final int? port;

  View({this.port = 3000, required this.controller}) {
    app.onNotFound = notFoundHandler;
    app.onInternalError = internalErrorHandler;
    app.all('*', cors(origin: '*'));

    TradeRoute(app.route('trades'), trade: controller.trade);
    PositionRoute(app.route('positions'));
    StockRoute(app.route('stocks'));
    PortfolioRoute(app.route('portfolios'));
    DividendRoute(app.route('dividends'), dividend: controller.dividend);

    app.get('/', (req, res) => {'ok': true});
    app.listen(port!);
  }

  Future<View> start() async {
    await app.listen(port!);
    Logger().i('${DateTime.now()} - listening on port :$port');
    return this;
  }

  Future<void> close() async => await app.close();

  FutureOr notFoundHandler(HttpRequest request, HttpResponse response) =>
      {'ok': false, 'msg': 'Not found'};

  FutureOr internalErrorHandler(HttpRequest request, HttpResponse response) =>
      {'ok': false, 'msg': 'Internal error'};
}
