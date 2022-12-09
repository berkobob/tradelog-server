import 'package:get_it/get_it.dart';
import 'package:server/controllers/controller.dart';
import 'package:server/services/database_service.dart';
import 'package:server/services/mongodb.dart';
import 'package:test/test.dart';

main() {
  group('New dividend', () {
    final data = <String, dynamic>{
      "SettleDate": "20210326",
      "Symbol": "PSN",
      "Description":
          "PSN(GB0006825383) CASH DIVIDEND GBP 1.25 PER SHARE (Ordinary Dividend)",
      "Amount": "1375",
      "Portfolio": "testPort"
    };
    late Map<String, dynamic> result;

    setUpAll(() async {
      GetIt.I.registerSingletonAsync<DatabaseService>(
          () async => await MongoDB(database: "testdb").open());
      await GetIt.I.allReady();
    });

    test('Expect commission to be processed succesfully', () {
      result = Controller().dividend(data);
      final divi = result['dividends'];
      expect(result['success'], isTrue);
      expect(divi, isA<Map<String, dynamic>>());
    });
  });
}
