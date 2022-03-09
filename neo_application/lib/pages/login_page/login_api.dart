import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:neo_application/pages/login_page/user_model.dart';
import 'package:neo_application/pages/login_page/user_token.dart';

class LoginModel {
  UserToken userToken = UserToken();
  Future login(String username, String password) async {
    try {
      var url = Uri.parse("https://neo-ii-back-end.azurewebsites.net/auth");

      Map<String, String> body = {
        "username": username,
        "password": password,
      };

      var response = await http.post(
        url,
        headers: <String, String>{"Content-type": "application/json"},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        var map = jsonDecode(response.body);

        userToken = UserToken.fromMap(map);

        await userToken.saveToken(userToken.access_token!);

        return userToken;
      }
      if (response.statusCode == 401) {
        return userToken;
      }
    } catch (e) {
      print(e);
    }
  }
}
