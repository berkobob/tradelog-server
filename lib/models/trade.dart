import 'base_model.dart';

class Trade extends BaseModel<Trade> {
  static Future<Trade?> findOne(Json query) async {
    final result = await BaseModel.findOne(collection: 'trades', query: query);
    return result == null ? null : Trade.fromJson(result);
  }

  static Future<List<Trade>> find(Json query) async {
    final result = await BaseModel.find(collection: 'trades', query: query);
    return result.map((trade) => Trade.fromJson(trade)).toList();
  }

  static Future<Trade?> findById(dynamic id) async {
    final result = await BaseModel.findById(collection: 'trades', id: id);
    return result == null ? null : Trade.fromJson(result);
  }

  late DateTime date;
  late String bos;
  late String symbol;
  late String stock;
  DateTime? expiry;
  double? strike;
  String? poc;
  late double price;
  late String asset;
  String? ooc;
  late int multiplier;
  String? notes;
  String? tradeid;
  String? currency;
  double? fx;
  late String description;

  Trade.fromJson(Json json)
      : date = json['date'],
        bos = json['bos'],
        symbol = json['symbol'],
        stock = json['stock'],
        expiry = json['expiry'],
        strike = json['strike'],
        poc = json['poc'],
        price = json['price'],
        asset = json['asset'],
        ooc = json['ooc'],
        multiplier = json['multiplier'],
        notes = json['notes'],
        tradeid = json['tradeid'],
        currency = json['currency'],
        fx = json['fx'],
        description = json['description'],
        super.fromJson(json);

  @override
  Json toJson() => {
        '_id': id,
        'date': date,
        'bos': bos,
        'quantity': quantity,
        'symbol': symbol,
        'stock': stock,
        'expiry': expiry,
        'strike': strike,
        'poc': poc,
        'price': price,
        'proceeds': proceeds,
        'commission': commission,
        'cash': cash,
        'asset': asset,
        'ooc': ooc,
        'multiplier': multiplier,
        'notes': notes,
        'tradeid': tradeid,
        'currency': currency,
        'fx': fx,
        'portfolio': portfolio,
        'description': description,
        'risk': risk
      };
}
