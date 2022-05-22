import 'dart:convert';

import 'package:get_it/get_it.dart';

import '../services/database_service.dart';

export '../constants.dart';

abstract class BaseModel<T extends BaseModel<T>> {
  static Future<Json?> findOne(
      {required String collection, required Json query}) async {
    final result =
        await GetIt.I.get<DatabaseService>().findOne(collection, query);
    return result;
  }

  static Future<List<Json>> find(
      {required String collection, required Json query}) async {
    return await GetIt.I.get<DatabaseService>().find(collection, query);
  }

  static Future<Json?> findById(
          {required String collection, required ObjectId id}) async =>
      await GetIt.I.get<DatabaseService>().findById(collection, id);

  String get collection => '${T.toString().toLowerCase()}s';
  dynamic id;
  String portfolio;
  double proceeds;
  double commission;
  double cash;
  double risk;
  int quantity = 0;

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
      id = await GetIt.I.get<DatabaseService>().save(collection, toJson());
    } else {
      await GetIt.I.get<DatabaseService>().update(collection, id, toJson());
    }
    return this as T;
  }

  Future<T> delete() async {
    await GetIt.I.get<DatabaseService>().delete(collection, id);
    return this as T;
  }

  Future<T> update(Json json) async {
    await GetIt.I.get<DatabaseService>().update(collection, id, json);
    return this as T;
  }

  @override
  String toString() => json.encode(toJson(), toEncodable: toEncodable);

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

dynamic toEncodable(item) {
  if (item is DateTime) return item.toString();
  if (item is double) return item.toString();
  return item.toJson();
}
