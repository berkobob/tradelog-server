import 'base_model.dart';

class Position extends BaseModel<Position> {
  static Future<Position?> findOne(Json query) async {
    final result =
        await BaseModel.findOne(collection: 'positions', query: query);
    return result == null ? null : Position.fromJson(result);
  }

  static Future<List<Position>> find(Json query) async {
    final result = await BaseModel.find(collection: 'positions', query: query);
    return result.map((position) => Position.fromJson(position)).toList();
  }

  static Future<Position?> findById(dynamic id) async {
    final result = await BaseModel.findById(collection: 'positions', id: id);
    return result == null ? null : Position.fromJson(result);
  }

  String stock;
  String symbol;
  String description;
  String? currency;
  DateTime open;
  DateTime? closed;
  List<dynamic> trades = [];
  int? days;
  String asset;

  bool get isClosed => quantity == 0;

  Position.fromJson(Json json)
      : stock = json['stock'],
        symbol = json['symbol'],
        description = json['description'],
        currency = json['currency'],
        open = json['open'],
        closed = json['closed'],
        trades = json['trades'],
        days = json['days'],
        asset = json['asset'],
        super.fromJson(json);

  @override
  Json toJson() => {
        '_id': id,
        'portfolio': portfolio,
        'stock': stock,
        'symbol': symbol,
        'description': description,
        'quantity': quantity,
        'proceeds': proceeds,
        'commission': commission,
        'cash': cash,
        'currency': currency,
        'risk': risk,
        'open': open,
        'closed': closed,
        'trades': trades,
        'days': days,
        'asset': asset,
      };
}
