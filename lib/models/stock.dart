import 'base_model.dart';

class Stock extends BaseModel<Stock> {
  static Future<Stock?> findOne(Json query) async {
    final result = await BaseModel.findOne(collection: 'stocks', query: query);
    return result == null ? null : Stock.fromJson(result);
  }

  static Future<List<Stock>> find(Json query) async {
    final result = await BaseModel.find(collection: 'stocks', query: query);
    return result.map((stock) => Stock.fromJson(stock)).toList();
  }

  static Future<Stock?> findById(dynamic id) async {
    final result = await BaseModel.findById(collection: 'stocks', id: id);
    return result == null ? null : Stock.fromJson(result);
  }

  String stock;
  List<dynamic> open = [];
  List<dynamic> closed = [];
  String? currency;

  @override
  int get quantity => open.length + closed.length;

  Stock.fromJson(Json json)
      : stock = json['stock'],
        open = json['open'],
        closed = json['closed'],
        currency = json['currency'],
        super.fromJson(json);

  @override
  Json toJson() => {
        '_id': id,
        'portfolio': portfolio,
        'stock': stock,
        'open': open,
        'closed': closed,
        'proceeds': proceeds,
        'commission': commission,
        'cash': cash,
        'risk': risk,
        'currency': currency,
        'quantity': quantity
      };
}
