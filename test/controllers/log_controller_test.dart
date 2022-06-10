import 'package:get_it/get_it.dart';
import 'package:server/controllers/log_controller.dart';
import 'package:server/models/models.dart';
import 'package:server/services/database_service.dart';
import 'package:test/test.dart';

import 'trade_data.dart';

main() {
  LogController log = LogController();

  setUpAll(() async {
    final db = await DatabaseService(database: "testdb").open();
    (await db.drop()).close();

    GetIt.I.registerSingletonAsync<DatabaseService>(
        () async => await DatabaseService(database: "testdb").open());
    await GetIt.I.allReady();
  });

  group('Open a new UK Option position:', () {
    late Portfolio? portfolio;
    late Stock? stock;
    late Position? position;
    late Trade? trade;

    setUpAll(() async {
      final result = await log.trade(openOptionTrade);
      result['trade']['date'] = DateTime.tryParse(result['trade']['date']);
      result['trade']['expiry'] = DateTime.tryParse(result['trade']['expiry']);
      trade = Trade.fromJson(result['trade']);
      position = await Position.findOne({'symbol': trade?.symbol});
      stock = await Stock.findOne({'stock': trade?.stock});
      portfolio = await Portfolio.findOne(({'portfolio': trade?.portfolio}));
    });

    test('Successfully open a trade', () {
      expect(trade, isA<Trade>());
      expect(position, isA<Position>());
      expect(stock, isA<Stock>());
      expect(portfolio, isA<Portfolio>());
    });

    group(' - POSITION - ', () {
      test('Expect a new position to be created',
          () => expect(position, isA<Position>()));

      test('expect stock to be SBRY',
          () => expect(position?.stock, equals('SBRY')));

      test('expect symbol to be SAN NOV20 1.8 P',
          () => expect(position?.symbol, equals('SAN NOV20 1.8 P')));
      test('expect quantity to be -1',
          () => expect(position?.quantity, equals(-1)));
      test('expect proceeds to be 25',
          () => expect(position?.proceeds, equals(25)));
      test('expect commission to be -1.7',
          () => expect(position?.commission, equals(-1.7)));
      test(
          'expect cash to be 23.3', () => expect(position?.cash, equals(23.3)));
      test('expect risk to be -1800',
          () => expect(position?.risk, equals(-1800)));
      test(
          'expect open to be 20201106',
          () => expect(position?.open.toIso8601String(),
              equals('2020-11-06T00:00:00.000Z')));
      test('expect closed to be null', () => expect(position?.closed, isNull));
      test('expect days to be null', () => expect(position?.days, isNull));
      test('expect risk to be -1800',
          () => expect(position?.risk, equals(-1800)));
    });

    group(' - STOCK -', () {
      test('Expect stock to be SBRY',
          () => expect(stock?.stock, equals('SBRY')));
      test('Expect position id to be open',
          () => expect(stock?.open.contains(position?.id), isTrue));
      test('Expect closed to be empty',
          () => expect(stock?.closed.length, isZero));
      test('Expect proceeds to be 25',
          () => expect(stock?.proceeds, equals(25)));
      test('Expect commission to be -1.7',
          () => expect(stock?.commission, equals(-1.7)));
      test('Expect cash to be 23.3', () => expect(stock?.cash, equals(23.3)));
      test(
          'Expect quantity to be 1',
          () => expect(stock?.quantity, equals(1),
              reason: 'Stock quantity should be 1'));
    });

    group(' - PORTFOLIO - ', () {
      test('Portfolio is test',
          () => expect(portfolio?.portfolio, equals('test')));
      test('Portfolio contains SBRY',
          () => expect(portfolio?.stocks, contains('SBRY')));
      test('Proceeds are 25', () => expect(portfolio?.proceeds, equals(25)));
      test('commission are -1.7',
          () => expect(portfolio?.commission, equals(-1.7)));
      test('cash are 23.3', () => expect(portfolio?.cash, equals(23.3)));
      test('risk is -1800', () => expect(portfolio?.risk, equals(-1800)));
      test('quantity is one', () => expect(portfolio?.quantity, equals(1)));
    });
  });

  group('Close the UK Option position', () {
    late Portfolio? portfolio;
    late Stock? stock;
    late Position? position;
    late Trade? trade;

    setUpAll(() async {
      final result = await log.trade(closeOptionTrade);
      result['trade']['date'] = DateTime.tryParse(result['trade']['date']);
      result['trade']['expiry'] = DateTime.tryParse(result['trade']['expiry']);
      trade = Trade.fromJson(result['trade']);
      position = await Position.findOne({'symbol': trade?.symbol});
      stock = await Stock.findOne({'stock': trade?.stock});
      portfolio = await Portfolio.findOne(({'portfolio': trade?.portfolio}));
    });

    test('Successfully process another trade', () {
      expect(trade, isA<Trade>());
      expect(stock, isA<Stock>());
    });

    group(' - POSITION - ', () {
      test('Expect to find an open position', () {
        expect(position, isA<Position>());
      });

      test('expect quantity to be 0',
          () => expect(position?.quantity, equals(0)));
      test('expect proceeds to be 25',
          () => expect(position?.proceeds, equals(25)));
      test('expect commission to be -1.7',
          () => expect(position?.commission, equals(-1.7)));
      test(
          'expect cash to be 23.3', () => expect(position?.cash, equals(23.3)));
      test('expect risk to be 0', () => expect(position?.risk, equals(0)));
      test(
          'expect closed to be 20201120',
          () => expect(position?.closed!.toIso8601String(),
              equals('2020-11-20T00:00:00.000Z')));
      test('expect days to be 14',
          () => expect(position?.days, equals(equals(14))));
    });

    group(' - STOCK -', () {
      test('Expect stock to be SBRY',
          () => expect(stock?.stock, equals('SBRY')));
      test('Expect closed to be empty',
          () => expect(stock?.open.length, isZero));
      test('Expect position id to be open',
          () => expect(stock?.closed.contains(position?.id), isTrue));
      test('Expect proceeds to be 25',
          () => expect(stock?.proceeds, equals(25)));
      test('Expect commission to be -1.7',
          () => expect(stock?.commission, equals(-1.7)));
      test('Expect cash to be 23.3', () => expect(stock?.cash, equals(23.3)));
      test(
          'Expect quantity to be 1',
          () => expect(stock?.quantity, equals(1),
              reason: 'Still just one trade'));
      test('Expect risk to be zero', () => expect(stock?.risk, equals(0)));
    });

    group(' - PORTFOLIO - ', () {
      test('Portfolio exists',
          () => expect(portfolio?.portfolio, equals('test')));
      test('Portfolio contains SBRY',
          () => expect(portfolio?.stocks, contains('SBRY')));
      test('Proceeds are 24', () => expect(portfolio?.proceeds, equals(25)));
      test('commission are -1.7',
          () => expect(portfolio?.commission, equals(-1.7)));
      test('cash is 23.3', () => expect(portfolio?.cash, equals(23.3)));
      test('risk is zero', () => expect(portfolio?.risk, equals(0)));
      test('quantity is one', () => expect(portfolio?.quantity, equals(1)));
    });
  });
}
