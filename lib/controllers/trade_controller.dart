import '../constants.dart';
import '../models/trade.dart';

Json newTrade(Json json) {
  var error = false;
  Json trade = {};

  // Date
  try {
    trade['date'] = DateTime.parse(json['TradeDate']);
  } catch (e) {
    json['TradeDate'] =
        (json['TradeDate'] ?? 'TradeDate missing') + ' - ERROR: $e';
    error = true;
  }

  // Buy or Sell
  // if (['BUY', 'SELL'].contains(json['Buy/Sell'].substring(0, 3))) {
  if (json.keys.contains('Buy/Sell')) {
    if (json['Buy/Sell'].contains('BUY')) {
      trade['bos'] = 'BUY';
    } else if (json['Buy/Sell'].contains('SELL')) {
      trade['bos'] = 'SELL';
    } else {
      json['Buy/Sell'] =
          json['Buy/Sell'] + ' - ERROR: Must be either BUY or SELL';
      error = true;
    }
  } else {
    json['Buy/Sell'] = 'Buy/Sell missing - ERROR: Must be either BUY or SELL';
  }

  // Quantity
  try {
    trade['quantity'] = num.parse(json['Quantity']);
  } catch (e) {
    json['Quantity'] =
        (json['Quantity'] ?? 'Quantity missing') + ' - ERROR: $e';
    error = true;
  }

  // Symbol
  try {
    trade['symbol'] = json['Symbol'] as String;
  } catch (e) {
    json['Symbol'] = (json['Symbol'] ?? 'Symbol missing') + ' - ERROR: $e';
  }

  // Stock
  try {
    if (json['UnderlyingSymbol'] == null || json['UnderlyingSymbol'] == '') {
      trade['stock'] = trade['symbol'].split(' ')[0] as String;
      if (trade['stock'].length == 4 &&
          int.tryParse(trade['stock'][3]) != null) {
        trade['stock'] = trade['stock'].substring(0, 3);
      } else if (trade['stock'].length == 5 &&
          int.tryParse(trade['stock'][4]) != null) {
        trade['stock'] = trade['stock'].substring(0, 4);
      }
    } else {
      trade['stock'] = json['UnderlyingSymbol'];
    }
  } catch (e) {
    json['UnderlyingSymbol'] = (json['UnderlyingSymbol'] ?? '') +
        ' - ERROR: Unable to calculate underlying stock symbol';
    error = true;
  }

  // Asset class
  if (['STK', 'OPT'].contains(json['AssetClass'])) {
    trade['asset'] = json['AssetClass'];
  } else {
    json['AssetClass'] = (json['AssetClass'] ?? 'Asset class missing') +
        ' - ERROR: Must be either STK or OPT';
    error = true;
  }

  //
  // Options attributes
  //
  if (json['AssetClass'] == 'OPT') {
    // Expiry
    try {
      String date = (json['Expiry'].contains('/'))
          ? '${json['Expiry'].substring(6, 10)}${json['Expiry'].substring(3, 5)}'
              '${json['Expiry'].substring(0, 2)}'
          : json['Expiry'];
      trade['expiry'] = DateTime.parse(date);
    } catch (e) {
      json['Expiry'] = (json['Expiry'] ?? 'Expiry missing') + ' - ERROR: $e';
      error = true;
    }

    // Strike
    try {
      trade['strike'] = double.parse(json['Strike']);
    } catch (e) {
      json['Strike'] =
          (json['Strike'] ?? 'Strike price date missing') + ' - ERROR: $e';
      error = true;
    }

    // Put or Call
    if (['P', 'C'].contains(json['Put/Call'])) {
      trade['poc'] = json['Put/Call'];
    } else {
      json['Put/Call'] = (json['Put/Call'] ?? 'Put/Call flag missing') +
          ' - ERROR: Must be either P or C';
      error = true;
    }
    // end options attributes
  }

  // Trade Price
  try {
    final price = json['Price'] ?? json['TradePrice'];
    trade['price'] = double.parse(price);
  } catch (e) {
    json['Price'] = (json['Price'] ?? 'Trade price missing') + ' - ERROR: $e';
    error = true;
  }

  // Proceeds
  try {
    trade['proceeds'] = double.parse(json['Proceeds']);
  } catch (e) {
    json['Proceeds'] =
        (json['Proceeds'] ?? 'Trade proceeds missing') + ' - ERROR: $e';
    error = true;
  }

  // Commission
  try {
    trade['commission'] = double.parse(json['Commission']);
  } catch (e) {
    try {
      trade['commission'] = double.parse(json['IBCommission']);
    } catch (e) {
      json['Commission'] =
          (json['Commission'] ?? 'Trade Commission missing') + ' - ERROR: $e';
      error = true;
    }
  }

  // Cash
  try {
    trade['cash'] = double.parse(json['NetCash']);
  } catch (e) {
    try {
      trade['cash'] = double.parse(json['Cash']);
    } catch (e) {
      try {
        trade['cash'] = trade['proceeds'] + trade['commission'];
      } catch (f) {
        json['Cash'] = (json['Cash'] ?? 'Trade cash missing') + ' - ERROR: $e';
        error = true;
      }
    }
  }

  // Open or Close flag
  trade['ooc'] = json['Open/CloseIndicator'];
  trade['ooc'] ??= json['Code'] != null
      ? json['Code'].contains('O')
          ? 'O'
          : json['Code'].contains('C')
              ? 'C'
              : null
      : null;

  // Multiplier
  try {
    trade['multiplier'] = int.parse(json['Multiplier']);
  } catch (e) {
    json['Multiplier'] =
        (json['Multiplier'] ?? 'Trade Multiplier missing') + ' - ERROR: $e';
    error = true;
  }

  // Notes
  trade['notes'] = json['Notes/Codes'] ?? json['Code'];

  // Trade ID
  trade['tradeid'] = json['TradeID'];

  // Currency
  trade['currency'] = json['CurrencyPrimary'];

  // FX rate to GBP
  try {
    trade['fx'] = double.tryParse(json['FXRateToBase']);
  } catch (e) {
    if (json.keys.contains('FXRateToBase')) {
      json['FXRateToBase'] += ' - ERROR: $e';
    }
  }

  // Portfolio
  if (json.keys.contains('Portfolio') && json['Portfolio'] != '') {
    trade['portfolio'] = json['Portfolio'];
  } else {
    json['Portfolio'] = ' - ERROR: Valid portfolio name missing';
    error = true;
  }

  // Return any errors
  if (error) return {'success': false, 'errors': json};

  // Risk
  if (trade['quantity'] > 0) {
    // Long
    if (trade['asset'] == 'OPT' && trade['notes'].contains('C')) {
      trade['risk'] = trade['quantity'] * trade['multiplier'] * trade['strike'];
    } else {
      trade['risk'] = trade['cash'];
    }
  } else if (trade['quantity'] < 0) {
    // Short
    if (trade['asset'] == 'OPT' && trade['poc'] == 'P') {
      // Short put trade
      trade['risk'] = trade['quantity'] * trade['multiplier'] * trade['strike'];
    } else {
      // Short stock or short call
      trade['risk'] = 0.0; // aLargeNum;
    }
  } else {
    trade['risk'] = 0.0;
  }

  // Description
  trade['description'] = json['Description'] ?? '';

  return {'success': true, 'trade': Trade.fromJson(trade)};
}
