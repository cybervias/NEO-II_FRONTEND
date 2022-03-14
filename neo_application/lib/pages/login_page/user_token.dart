import 'dart:convert';

import 'package:neo_application/prefs/shared_preferences.dart';

class UserToken {
  String? access_token;
  UserToken({
    this.access_token,
  });

  Map<String, dynamic> toMap() {
    return {
      'access_token': access_token,
    };
  }

  factory UserToken.fromMap(Map<String, dynamic> map) {
    return UserToken(
      access_token: map['access_token'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserToken.fromJson(String source) =>
      UserToken.fromMap(json.decode(source));

  saveToken(String token) async {
    Preferences prefs = Preferences();
    await prefs.addAccessToken(token);
  }

  Future<String> getToken() async {
    Preferences prefs = Preferences();
    String token = await prefs.getAccessToken();

    return token;
  }
}
