import '../constants.dart';
import '../models/models.dart';

Json dividend(Json json) {
  bool error = false;

  // Date
  try {
    json['date'] = DateTime.parse(json['SettleDate']);
  } catch (e) {
    json['date'] = (json['SettleDate'] ?? 'Date missing') + ' - ERROR: $e';
    error = true;
  }

  // Symbol
  try {
    json['symbol'] = json['Symbol'] as String;
  } catch (e) {
    json['symbol'] = (json['Symbol'] ?? 'Symbol missing') + ' - ERROR: $e';
  }

  // Description
  json['description'] = json['Description'] ?? '';

  // Amount
  try {
    json['amount'] = double.parse(json['Amount']);
    json['proceeds'] = json['amount'];
    json['commission'] = 0.0;
    json['cash'] = json['amount'];
    json['risk'] = 0.0;
    json['quantity'] = 0;
  } catch (e) {
    json['amount'] = (json['Amount'] ?? 'Amount missing') + ' - ERROR $e';
  }

  // Portfolio
  if (json.keys.contains('Portfolio') && json['Portfolio'] != '') {
    json['portfolio'] = json['Portfolio'];
  } else {
    json['portfolio'] = ' - ERROR: Valid portfolio name missing';
    error = true;
  }

  if (error) {
    json['date'] = json['date'].toString();
    return {'success': false, 'msg': json};
  }

  final dividend = Dividend.fromJson(json)..save();
  Stock.findOne({'stock': dividend.symbol}).then((stock) {
    stock?.update({'dividends': stock.dividends += dividend.cash});
  });
  Portfolio.findOne({'portfolio': dividend.portfolio}).then((port) {
    port?.update({'dividends': port.dividends += dividend.cash});
  });

  return {'success': true, 'dividends': dividend.response};
}
