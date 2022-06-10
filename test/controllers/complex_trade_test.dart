import 'package:get_it/get_it.dart';
import 'package:server/controllers/log_controller.dart';
import 'package:server/models/models.dart';
import 'package:server/services/database_service.dart';
import 'package:test/test.dart';

import 'trade_data.dart';

main() {
  LogController log = LogController();

  setUpAll(() async {
    final db = await DatabaseService(database: "test").open();
    (await db.drop()).close();

    GetIt.I.registerSingletonAsync<DatabaseService>(
        () async => await DatabaseService(database: "test").open());
    await GetIt.I.allReady();
  });

  group('Multiple UK Stock trades - ', () {
    group('Open ULVR:', () {
      late Portfolio? portfolio;
      late Stock? stock;
      late Position? position;
      late Trade? trade;

      setUpAll(() async {
        final result = await log.trade(openULVR);
        result['trade']['date'] = DateTime.tryParse(result['trade']['date']);
        trade = Trade.fromJson(result['trade']);
        position = await Position.findOne({'symbol': trade?.symbol});
        stock = await Stock.findOne({'stock': trade?.stock});
        portfolio = await Portfolio.findOne(({'portfolio': trade?.portfolio}));
      });

      test('Trade quantity', () => expect(trade?.quantity, equals(400)));
      test('Trade proceeds', () => expect(trade?.proceeds, equals(-15260)));
      test('Trade risk', () => expect(trade?.risk, equals(-15266)));
      test('Trade commission', () => expect(trade?.commission, equals(-6)));

      test('position quantity', () => expect(position?.quantity, equals(400)));
      test('position proceeds',
          () => expect(position?.proceeds, equals(-15260)));
      test('position risk', () => expect(position?.risk, equals(-15266)));
      test('position commission',
          () => expect(position?.commission, equals(-6)));

      test('stock quantity', () => expect(stock?.quantity, equals(1)));
      test('stock proceeds', () => expect(stock?.proceeds, equals(-15260)));
      test('stock commission', () => expect(stock?.commission, equals(-6)));

      test('portfolio quantity', () => expect(portfolio?.quantity, equals(1)));
      test('portfolio proceeds',
          () => expect(portfolio?.proceeds, equals(-15260)));
      test('portfolio risk', () => expect(portfolio?.risk, equals(-15266)));
      test('portfolio commission',
          () => expect(portfolio?.commission, equals(-6)));
    }); // Open ULVR

    group('Add to ULVR:', () {
      late Portfolio? portfolio;
      late Stock? stock;
      late Position? position;
      late Trade? trade;

      setUpAll(() async {
        final result = await log.trade(addULVR);
        result['trade']['date'] = DateTime.tryParse(result['trade']['date']);
        trade = Trade.fromJson(result['trade']);
        position = await Position.findOne({'symbol': trade?.symbol});
        stock = await Stock.findOne({'stock': trade?.stock});
        portfolio = await Portfolio.findOne(({'portfolio': trade?.portfolio}));
      });

      test('Trade quantity', () => expect(trade?.quantity, equals(200)));
      test('Trade proceeds', () => expect(trade?.proceeds, equals(-7976)));
      test('Trade risk', () => expect(trade?.risk, equals(-7982)));
      test('Trade commission', () => expect(trade?.commission, equals(-6)));

      test('position quantity', () => expect(position?.quantity, equals(600)));
      test('position proceeds',
          () => expect(position?.proceeds, equals(-23236)));
      test('position risk', () => expect(position?.risk, equals(-23248)));
      test('position commission',
          () => expect(position?.commission, equals(-12)));

      test('stock quantity', () => expect(stock?.quantity, equals(1)));
      test('stock proceeds', () => expect(stock?.proceeds, equals(-23236)));
      test('stock commission', () => expect(stock?.commission, equals(-12)));
      test('portfolio quantity', () => expect(portfolio?.quantity, equals(1)));
      test('portfolio proceeds',
          () => expect(portfolio?.proceeds, equals(-23236)));
      test('portfolio risk', () => expect(portfolio?.risk, equals(-23248)));
      test('portfolio commission',
          () => expect(portfolio?.commission, equals(-12)));
    }); // Add to ULVR

    group('Close ULVR:', () {
      late Portfolio? portfolio;
      late Stock? stock;
      late Position? position;
      late Trade? trade;

      setUpAll(() async {
        final result = await log.trade(closeULVR);
        result['trade']['date'] = DateTime.tryParse(result['trade']['date']);
        trade = Trade.fromJson(result['trade']);
        position = await Position.findOne({'symbol': trade?.symbol});
        stock = await Stock.findOne({'stock': trade?.stock});
        portfolio = await Portfolio.findOne(({'portfolio': trade?.portfolio}));
      });

      test('Trade quantity', () => expect(trade?.quantity, equals(-600)));
      test('Trade proceeds', () => expect(trade?.proceeds, equals(79760)));
      test('Trade risk', () => expect(trade?.risk, equals(23248)));
      test('Trade commission', () => expect(trade?.commission, equals(-60)));

      test('position quantity', () => expect(position?.quantity, isZero));
      test(
          'position proceeds', () => expect(position?.proceeds, equals(56524)));
      test('position risk', () => expect(position?.risk, equals(-23248)));
      test('position commission',
          () => expect(position?.commission, equals(-72)));
      test('position is closed', () => expect(position?.isClosed, isTrue));

      test('stock quantity', () => expect(stock?.quantity, equals(1)));
      test('stock proceeds', () => expect(stock?.proceeds, equals(56524)));
      test('stock commission', () => expect(stock?.commission, equals(-72)));

      test('portfolio quantity', () => expect(portfolio?.quantity, equals(1)));
      test('portfolio proceeds',
          () => expect(portfolio?.proceeds, equals(56524)));
      test('portfolio risk', () => expect(portfolio?.risk, isZero));
      test('portfolio commission',
          () => expect(portfolio?.commission, equals(-72)));
    }); // Close ULVR
  }); // Multiple UK Stock trades test

  group('Multiple UK Options trades - ', () {
    group('Open GSK:', () {
      late Portfolio? portfolio;
      late Stock? stock;
      late Position? position;
      late Trade? trade;

      setUpAll(() async {
        final result = await log.trade(openGSK);
        result['trade']['date'] = DateTime.tryParse(result['trade']['date']);
        result['trade']['expiry'] =
            DateTime.tryParse(result['trade']['expiry']);
        trade = Trade.fromJson(result['trade']);
        position = await Position.findOne({'symbol': trade?.symbol});
        stock = await Stock.findOne({'stock': trade?.stock});
        portfolio = await Portfolio.findOne(({'portfolio': trade?.portfolio}));
      });

      test('Trade quantity', () => expect(trade?.quantity, equals(-1)));
      test('Trade proceeds', () => expect(trade?.proceeds, equals(330)));
      test('Trade risk', () => expect(trade?.risk, equals(-13000)));
      test('Trade commission', () => expect(trade?.commission, equals(-1.7)));

      test('position quantity', () => expect(position?.quantity, equals(-1)));
      test('position proceeds', () => expect(position?.proceeds, equals(330)));
      test('position risk', () => expect(position?.risk, equals(-13000)));
      test('position commission',
          () => expect(position?.commission, equals(-1.7)));

      test('stock quantity', () => expect(stock?.quantity, equals(1)));
      test('stock proceeds', () => expect(stock?.proceeds, equals(330)));
      test('stock commission', () => expect(stock?.commission, equals(-1.7)));

      test('portfolio quantity', () => expect(portfolio?.quantity, equals(2)));
      test('portfolio proceeds',
          () => expect(portfolio?.proceeds, equals(56524 + 330)));
      test('portfolio risk', () => expect(portfolio?.risk, equals(-13000)));
      test('portfolio commission',
          () => expect(portfolio?.commission, equals(-72 - 1.7)));
    }); // Open GSK

    group('Add to GSK:', () {
      late Portfolio? portfolio;
      late Stock? stock;
      late Position? position;
      late Trade? trade;

      setUpAll(() async {
        final result = await log.trade(addGSK);
        result['trade']['date'] = DateTime.tryParse(result['trade']['date']);
        result['trade']['expiry'] =
            DateTime.tryParse(result['trade']['expiry']);
        trade = Trade.fromJson(result['trade']);
        position = await Position.findOne({'symbol': trade?.symbol});
        stock = await Stock.findOne({'stock': trade?.stock});
        portfolio = await Portfolio.findOne(({'portfolio': trade?.portfolio}));
      });

      test('Trade quantity', () => expect(trade?.quantity, equals(-1)));
      test('Trade proceeds', () => expect(trade?.proceeds, equals(330)));
      test('Trade risk', () => expect(trade?.risk, equals(-13000)));
      test('Trade commission', () => expect(trade?.commission, equals(-1.7)));

      test('position quantity', () => expect(position?.quantity, equals(-2)));
      test('position proceeds', () => expect(position?.proceeds, equals(660)));
      test('position risk', () => expect(position?.risk, equals(-26000)));
      test('position commission',
          () => expect(position?.commission, equals(-3.4)));

      test('stock quantity', () => expect(stock?.quantity, equals(1)));
      test('stock proceeds', () => expect(stock?.proceeds, equals(660)));
      test('stock commission', () => expect(stock?.commission, equals(-3.4)));
      test('portfolio quantity', () => expect(portfolio?.quantity, equals(2)));
      test('portfolio proceeds',
          () => expect(portfolio?.proceeds, equals(56524 + 660)));
      test('portfolio risk', () => expect(portfolio?.risk, equals(-26000)));
      test('portfolio commission',
          () => expect(portfolio?.commission, equals(-72 - 3.4)));
    }); // Add to GSK

    group('Close GSK:', () {
      late Portfolio? portfolio;
      late Stock? stock;
      late Position? position;
      late Trade? trade;

      setUpAll(() async {
        final result = await log.trade(closeGSK);
        result['trade']['date'] = DateTime.tryParse(result['trade']['date']);
        result['trade']['expiry'] =
            DateTime.tryParse(result['trade']['expiry']);
        trade = Trade.fromJson(result['trade']);
        position = await Position.findOne({'symbol': trade?.symbol});
        stock = await Stock.findOne({'stock': trade?.stock});
        portfolio = await Portfolio.findOne(({'portfolio': trade?.portfolio}));
      });

      test('Trade quantity', () => expect(trade?.quantity, equals(2)));
      test('Trade proceeds', () => expect(trade?.proceeds, equals(0)));
      test('Trade risk', () => expect(trade?.risk, equals(26000)));
      test('Trade commission', () => expect(trade?.commission, isZero));

      test('position quantity', () => expect(position?.quantity, isZero));
      test('position proceeds', () => expect(position?.proceeds, equals(660)));
      test('position risk', () => expect(position?.risk, isZero));
      test('position commission',
          () => expect(position?.commission, equals(-3.4)));
      test('position is closed', () => expect(position?.isClosed, isTrue));

      test('stock quantity', () => expect(stock?.quantity, equals(1)));
      test('stock proceeds', () => expect(stock?.proceeds, equals(660)));
      test('stock commission', () => expect(stock?.commission, equals(-3.4)));

      test('portfolio quantity', () => expect(portfolio?.quantity, equals(2)));
      test('portfolio proceeds',
          () => expect(portfolio?.proceeds, equals(56524 + 660)));
      test('portfolio risk', () => expect(portfolio?.risk, isZero));
      test('portfolio commission',
          () => expect(portfolio?.commission, equals(-72 - 3.4)));
    }); // Close GSK
  }); // Multiple UK Options trades test
}
