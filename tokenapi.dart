import 'package:pcbapp/ServiceVO/LoginRequest.dart';
import 'dart:convert' as convert;
import 'package:pcbapp/ServiceVO/LoginResponse.dart';
import 'api/api.dart';

Future<LoginResponse> tokenApi(LoginRequest loginRequest) async {
  String encodeData = convert.jsonEncode(loginRequest);
  Map<String, String> headers = {'Content-Type': 'application/json'};

  var response = await API.getLogin(encodeData, headers);

  LoginResponse? loginResponse;
  try {
    loginResponse = LoginResponse.fromJson(convert.jsonDecode(response.body));
  } catch (err) {
    print(err);
  }
  return loginResponse!;
}
