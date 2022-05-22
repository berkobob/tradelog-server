import '../constants.dart';

class Reply {
  bool ok;
  dynamic msg;
  int statusCode;

  Reply({this.ok = true, required this.msg, this.statusCode = 200});
  Json get response => {'ok': ok, 'msg': msg};
}
