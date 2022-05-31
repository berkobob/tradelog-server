import 'base_model.dart';

class Portfolio extends BaseModel<Portfolio> {
  static Future<Portfolio?> findOne(Json query) async {
    final result =
        await BaseModel.findOne(collection: 'portfolios', query: query);
    return result == null ? null : Portfolio.fromJson(result);
  }

  static Future<List<Portfolio>> find(Json query) async {
    final result = await BaseModel.find(collection: 'portfolios', query: query);
    return result.map((portfolio) => Portfolio.fromJson(portfolio)).toList();
  }

  static Future<Portfolio?> findById(dynamic id) async {
    final result = await BaseModel.findById(collection: 'portfolios', id: id);
    return result == null ? null : Portfolio.fromJson(result);
  }

  Set<dynamic> stocks = {};
  String? currency;
  num profit;

  @override
  int get quantity => stocks.length;

  Portfolio.fromJson(Json json)
      : stocks = json['stocks'].toSet(),
        currency = json['currency'],
        profit = json['profit'],
        super.fromJson(json);

  @override
  Json toJson() => {
        '_id': id,
        'portfolio': portfolio,
        'stocks': stocks.toList(),
        'proceeds': proceeds,
        'commission': commission,
        'cash': cash,
        'risk': risk,
        'currency': currency,
        'quantity': quantity,
        'profit': profit,
      };
}
