import 'dart:convert';

import 'package:server/controllers/trade_controller.dart';
import 'package:server/models/base_model.dart';
import 'package:server/models/trade.dart';
import 'package:test/test.dart';

import 'trade_data.dart';

JsonEncoder encoder = JsonEncoder.withIndent('  ');

main() {
  group('Process a valid option trade:', () {
    late Map<String, dynamic> result;
    late Trade trade;

    setUpAll(() async {
      result = newTrade(validOptionTrade);
      trade = result['trade'];
    });

    test('Trade was successfuly create', () {
      expect(result['success'], isTrue);
      expect(trade, isA<Trade>());
    });
    test('Date string recongised', () {
      expect(trade.date, isA<DateTime>());
      expect(trade.date.compareTo(DateTime.parse('20201105')), isZero);
    });
    test('Buy/Sell should be BUY or SELL', () {
      expect(trade.bos == 'BUY' || trade.bos == 'SELL', isTrue);
      expect(trade.bos, equals('SELL'));
    });
    test('Quanity should be a valid integer', () {
      expect(trade.quantity, isA<int>());
      expect(trade.quantity, equals(-1));
    });
    test('Symbol should be a valid string', () {
      expect(trade.symbol, isA<String>());
      expect(trade.symbol, equals('BP DEC20 1.8 P'));
    });
    test('Stock should be a valid string', () {
      expect(trade.stock, isA<String>());
      expect(trade.stock, equals('BP.'));
    });
    test('Asset should be STK or OPT', () {
      expect(trade.asset == 'STK' || trade.asset == 'OPT', isTrue);
      expect(trade.asset, equals('OPT'));
    });
    test('Expiry should be a valid date', () {
      expect(trade.expiry, isA<DateTime>());
      expect(trade.expiry?.compareTo(DateTime.parse('20201218')), isZero);
    });
    test('Strike should be a valid double', () {
      expect(trade.strike, isA<double>());
      expect(trade.strike, equals(1.8));
    });
    test('Put or Call should be P or C', () {
      expect(trade.poc == 'P' || trade.poc == 'C', isTrue);
      expect(trade.poc, equals('P'));
    });
    test('Price should be a valid double', () {
      expect(trade.price, isA<double>());
      expect(trade.price, equals(0.03));
    });
    test('Proceeds should be a valid double', () {
      expect(trade.proceeds, isA<double>());
      expect(trade.proceeds, equals(30));
    });
    test('Commission should be a valid double', () {
      expect(trade.commission, isA<double>());
      expect(trade.commission, equals(-1.7));
    });
    test('Cash should be a valid double', () {
      expect(trade.cash, isA<double>());
      expect(trade.cash, equals(28.3));
    });
    test('Mulitplier should be a valid integer', () {
      expect(trade.multiplier, isA<int>());
      expect(trade.multiplier, equals(1000));
    });
    test('Notes should exist', () {
      expect(trade.notes, isNotNull);
      expect(trade.notes, equals('O'));
    });
    test('Trade ID should exist', () {
      expect(trade.tradeid, isNotNull);
      expect(trade.tradeid, equals('3200040928'));
    });
    test('Currency should exist', () {
      expect(trade.currency, isNotNull);
      expect(trade.currency, equals('GBP'));
    });
    test('Description should exist',
        () => expect(trade.description, equals('BP. 18DEC20 1.8 P')));
    test('Risk is -1800', () => expect(trade.risk, equals(-1800)));
  });

  group('Process a trade with missing data:', () {
    late Map<String, dynamic> result;
    late Map<String, dynamic> errors;

    setUpAll(() async {
      result = newTrade({});
      errors = result['errors'];
    });
    test('Expect the result to produce an error', () {
      expect(result['success'], isFalse);
    });

    test('Expect trate date to fail', () {
      expect(errors['TradeDate'], contains('ERROR'));
    });
    test('Expect Buy/Sell flag to fail', () {
      expect(errors['Buy/Sell'], contains('ERROR'));
    });
    test('Expect quantity to fail', () {
      expect(errors['Quantity'], contains('ERROR'));
    });
    test('Expect symbol to fail', () {
      expect(errors['Symbol'], contains('ERROR'));
    });
    test('Expect underlying symbol to fail', () {
      expect(errors['UnderlyingSymbol'], contains('ERROR'));
    });
    test('Expect asset class symbol to fail', () {
      expect(errors['AssetClass'], contains('ERROR'));
    });
    test('Expect price to fail', () {
      expect(errors['Price'], contains('ERROR'));
    });
    test('Expect proceeds to fail', () {
      expect(errors['Proceeds'], contains('ERROR'));
    });
    test('Expect commission to fail', () {
      expect(errors['Commission'], contains('ERROR'));
    });
    test('Expect cash to fail', () {
      expect(errors['Cash'], contains('ERROR'));
    });
    test('Expect multiplier to fail', () {
      expect(errors['Multiplier'], contains('ERROR'));
    });
    test('Risk is 0', () => expect(errors['risk'], isNull));
  });

  group('Process a trade that has errors:', () {
    late Map<String, dynamic> result;
    late Map<String, dynamic> errors;
    setUpAll(() async {
      result = newTrade(errorTrade);
      errors = result['errors'];
    });
    test('Expect result to produce an error',
        () => expect(result['success'], isFalse));
    test('Invalid trade date',
        () => expect(errors['TradeDate'], contains('ERROR')));
    test('Invalid Buy/Sell',
        () => expect(errors['Buy/Sell'], contains('ERROR')));
    test('Invalid quantity',
        () => expect(errors['Quantity'], contains('ERROR')));
    test('Invalid asset class',
        () => expect(errors['AssetClass'], contains('ERROR')));
    test('Invalid price', () => expect(errors['Price'], contains('ERROR')));
    test('Invalid proceeds',
        () => expect(errors['Proceeds'], contains('ERROR')));
    test('Invalid commission',
        () => expect(errors['Commission'], contains('ERROR')));
    test('Invalid cash', () => expect(errors['Cash'], contains('ERROR')));
    test('Invalid multiplier',
        () => expect(errors['Multiplier'], contains('ERROR')));
    test('Risk is 0', () => expect(errors['risk'], isNull));
  });

  group('Process invalid options attributes: ', () {
    late Map<String, dynamic> result;
    late Map<String, dynamic> errors;

    setUpAll(() async {
      result = newTrade(invalidOptionTrade);
      errors = result['errors'];
    });

    test('Expect the trade to return an error',
        () => expect(result['success'], isFalse));
    test('Expect expiry to contain an error',
        () => expect(errors['Expiry'], contains('ERROR')));
    test('Expect strike to contain an error',
        () => expect(errors['Strike'], contains('ERROR')));
    test('Expect put/call flag to contain an error',
        () => expect(errors['Put/Call'], contains('ERROR')));
    test('Risk is 0', () => expect(errors['risk'], isNull));
  });

  group('Process options trade with missing options attributes:', () {
    late Map<String, dynamic> result;
    late Map<String, dynamic> errors;

    setUpAll(() async {
      result = newTrade({'AssetClass': 'OPT'});
      errors = result['errors'];
    });

    test('Process options trade with missing options attributes',
        () => expect(result['success'], isFalse));
    test('Expect expiry to throw an error',
        () => expect(errors['Expiry'], contains('ERROR')));
    test('Expect expiry to throw an error',
        () => expect(errors['Strike'], contains('ERROR')));
    test('Expect expiry to throw an error',
        () => expect(errors['Put/Call'], contains('ERROR')));
    test('Risk is 0', () => expect(errors['risk'], isNull));
  });

  group('Make sure the values are right on a US stock trade:', () {
    Trade? trade;

    setUpAll(() async {
      final result = newTrade(USStockTrade);
      trade = result['trade'];
    });

    test('Make sure we have a trade', () => expect(trade, isA<Trade>()));

    test(
        'Date correctly processed',
        () =>
            expect(trade?.date.compareTo(DateTime.parse('20220121')), isZero));

    test('Trade is a sell', () => expect(trade?.bos, equals('SELL')));

    test('Quanity is -100', () => expect(trade?.quantity, equals(-100)));

    test('Symbol is ATVI', () => expect(trade?.symbol, equals('ATVI')));
    test('Expiry is null', () => expect(trade?.expiry, isNull));
    test('Strike is null', () => expect(trade?.strike, isNull));
    test('Put/Call is null', () => expect(trade?.poc, isNull));
    test('Trade price is 65', () => expect(trade?.price, equals(65)));
    test('Proceeds is 6500', () => expect(trade?.proceeds, equals(6500)));
    test('Commission is -0.04615',
        () => expect(trade?.commission, equals(-0.04615)));
    test('Cash is 6499.95385', () => expect(trade?.cash, equals(6499.95385)));
    test('Asset is STK', () => expect(trade?.asset, equals('STK')));
    test('Trade is closed', () => expect(trade?.ooc, equals('C')));
    test('Multiplier is 1', () => expect(trade?.multiplier, equals(1)));
    test('Notes is A', () => expect(trade?.notes, equals('A')));
    test('Trade is 4416707873',
        () => expect(trade?.tradeid, equals('4416707873')));
    test('Currency is ISD', () => expect(trade?.currency, equals('USD')));
    test('Exchange rate is 0.7378', () => expect(trade?.fx, equals(0.7378)));
    test('Description contains Activision',
        () => expect(trade?.description, contains('ACTIVISION')));
    test('Risk is large', () => expect(trade?.risk, equals(aLargeNum)));
  });
}
