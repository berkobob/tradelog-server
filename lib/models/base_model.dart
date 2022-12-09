import 'package:get_it/get_it.dart';

import '../services/database_service.dart';

typedef Json = Map<String, dynamic>;

abstract class BaseModel<T extends BaseModel<T>> {
  static final DatabaseService db = GetIt.I.get<DatabaseService>();

  static Future<Json?> findOne(
      {required String collection, required Json query}) async {
    final result = await db.findOne(collection, query);
    return result;
  }

  static Future<List<Json>> find(
      {required String collection, required Json query}) async {
    return await db.find(collection, query);
  }

  static Future<Json?> findById(
          {required String collection, required dynamic id}) async =>
      await db.findById(collection, id);

  String get collection => '${T.toString().toLowerCase()}s';
  dynamic id;
  String portfolio;
  double proceeds;
  double commission;
  double cash;
  double risk;
  num quantity;

  BaseModel.fromJson(Json json)
      : id = json['_id'],
        portfolio = json['portfolio'],
        proceeds = json['proceeds'],
        commission = json['commission'],
        cash = json['cash'],
        risk = json['risk'],
        quantity = json['quantity'];

  Json toJson();

  Future<T> save() async {
    if (id == null) {
      id = await db.save(collection, toJson());
    } else {
      await db.update(collection, id, toJson());
    }

    return this as T;
  }

  Future<T> delete() async {
    await db.delete(collection, id);
    return this as T;
  }

  Future<T> update(Json json) async {
    await db.update(collection, id, json);
    return this as T;
  }

  T operator +(BaseModel other) {
    proceeds += other.proceeds;
    commission += other.commission;
    cash += other.cash;
    risk += other.risk;
    quantity += other.quantity;
    return this as T;
  }

  Json get response {
    final json = toJson();
    json.forEach((key, value) {
      if (value is DateTime) json[key] = value.toIso8601String();
    });
    return json;
  }
}
