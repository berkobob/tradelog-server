abstract class ControllerInterface {
  Future<Map<String, dynamic>> trade(Map<String, dynamic> json);
  Future<Map<String, dynamic>> dividend(Map<String, dynamic> json);
}
