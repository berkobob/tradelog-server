import 'package:server/models/base_model.dart';

class Test extends BaseModel<Test> {
  int anInt;
  String aString;

  Test({required this.anInt, required this.aString})
      : super.fromJson({
          'portfolio': 'portfolio',
          'proceeds': 0.0,
          'commission': 0.0,
          'cash': 0.0,
          'risk': 0.0,
          'quantity': 1
        });

  Test.fromJson(json)
      : anInt = json['anInt'],
        aString = json['aString'],
        super.fromJson({
          'portfolio': 'portfolio',
          'proceeds': 0.0,
          'commission': 0.0,
          'cash': 0.0,
          'risk': 0.0,
          'quantity': 1
        });

  static Future<Test?> findOne(Map<String, dynamic> query) async {
    final result = await BaseModel.findOne(collection: 'tests', query: query);
    return result == null ? null : Test.fromJson(result);
  }

  static Future<List<Test>> find(Map<String, dynamic> query) async {
    final result = await BaseModel.find(collection: 'tests', query: query);
    return result.map((test) => Test.fromJson(test)).toList();
  }

  static Future<Test?> findById(dynamic id) async {
    final result = await BaseModel.findById(collection: 'tests', id: id);
    return result == null ? null : Test.fromJson(result);
  }

  @override
  Map<String, dynamic> toJson() =>
      {'_id': id, 'anInt': anInt, 'aString': aString};
}
