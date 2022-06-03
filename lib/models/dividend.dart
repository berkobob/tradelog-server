import 'base_model.dart';

class Dividend extends BaseModel<Dividend> {
  static Future<Dividend?> findOne(Json query) async {
    final result =
        await BaseModel.findOne(collection: 'dividends', query: query);
    return result == null ? null : Dividend.fromJson(result);
  }

  static Future<List<Dividend>> find(Json query) async {
    final result = await BaseModel.find(collection: 'dividends', query: query);
    return result.map((dividend) => Dividend.fromJson(dividend)).toList();
  }

  static Future<Dividend?> findById(dynamic id) async {
    final result = await BaseModel.findById(collection: 'dividends', id: id);
    return result == null ? null : Dividend.fromJson(result);
  }

  DateTime date;
  String symbol;
  String description;

  Dividend.fromJson(Json json)
      : date = json['date'],
        symbol = json['symbol'],
        description = json['description'],
        super.fromJson(json);

  @override
  Json toJson() => {
        '_id': id,
        'portfolio': portfolio,
        'date': date,
        'symbol': symbol,
        'description': description,
        'quantity': quantity,
        'proceeds': proceeds,
        'commission': commission,
        'cash': cash,
        'risk': risk,
      };
}
