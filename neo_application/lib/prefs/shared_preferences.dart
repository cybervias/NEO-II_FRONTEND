import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  addAccessToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('access_token', token);
  }

  getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString('access_token');
    return stringValue;
  }
}
