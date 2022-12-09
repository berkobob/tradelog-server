part of 'controller.dart';

extension LogControllerExtension on Controller {
  Future<Json> trade(Json json) async {
    num profit = 0.0;
    //
    // Process trade
    //
    final result = newTrade(json);
    if (!result['success']) return result;
    final trade = result['trade']..save();

    //
    // Process position
    //
    num? risk;
    Position? position = await Position.findOne(
        {'symbol': trade.symbol, 'days': null, 'portfolio': trade.portfolio});
    if (position != null) {
      // Position exists
      risk = position.risk * -1;
      position += trade;
      position.trades.add(trade.id);
    } else {
      // New position
      position = Position.fromJson(trade.toJson()
        ..addAll({
          '_id': null,
          'trades': [trade.id],
          'open': trade.date,
          'risk': trade.risk,
          'asset': trade.asset,
        }));
    }
    position.save();

    if (position.isClosed) {
      // Close position
      position.closed = trade.date;
      position.days = position.closed!.difference(position.open).inDays;
      trade.risk = risk ?? trade.risk; // to calculate stock * port risk
      // trade.update({'risk': trade.risk});
      position.save();
      profit = position.proceeds;
    }

    //
    // Process stock
    //
    Stock? stock = await Stock.findOne(
        {'stock': trade.stock, 'portfolio': trade.portfolio});
    if (stock != null) {
      // Existing stock
      if (!stock.open.contains(position.id)) {
        // New position
        stock.open.add(position.id);
      }
      stock += trade;
    } else {
      // New Stock
      stock = Stock.fromJson(trade.toJson()
        ..addAll({
          '_id': null,
          'open': [position.id],
          'closed': <dynamic>[],
          'quantity': 1,
          'profit': profit,
        }));
    }
    if (position.isClosed) {
      // Existing position now closed
      stock.open.remove(position.id);
      stock.closed.add(position.id);
      stock.profit += profit;
    }
    stock.save();

    //
    // Process portfolio
    //
    Portfolio? portfolio =
        await Portfolio.findOne({'portfolio': trade.portfolio});

    if (portfolio != null) {
      // Existing portfolio
      portfolio.stocks.add(stock.stock);
      portfolio += trade;
      portfolio.profit += profit;
    } else {
      // New portfolio
      portfolio = Portfolio.fromJson(trade.toJson()
        ..addAll({
          '_id': null,
          'stocks': [stock.stock],
          'profit': profit,
        }));
    }
    portfolio.save();

    return {
      'trade': trade.response,
      'position': position.response,
      'stock': stock.response,
      'portfolio': portfolio.response
    };
  }
}
