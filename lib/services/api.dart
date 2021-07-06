import 'dart:convert';

import 'package:genius_notes_mobile/models/profile.dart';
import 'package:http/http.dart' as http;

class Api {
  static const baseUrl = 'https://genius-notes.herokuapp.com/';
  static const registerUrl = baseUrl + 'register';
  static const loginUrl = baseUrl + 'login';
  static const createUserUrl = baseUrl + 'createUser';
  static const logoutUrl = baseUrl + 'logout';
  static const headers = {
    'accept': 'application/json',
    'token': 'xdxdxd',
    'Content-Type': 'application/json'
  };

  static Future<Map<String, Object>> register(String username, String email) async {
    var uriUrl = Uri.parse(registerUrl);
    var response = await http.post(
      uriUrl,
      headers: headers,
      body: jsonEncode({
        'username': username,
        'userMail': email,
      })
    );
    var json = jsonDecode(response.body);

    return json;
  }

  static Future createUser(String username, String email) async {
    var uriUrl = Uri.parse(createUserUrl);
    var response = await http.post(
      uriUrl,
      headers: headers,
      body: jsonEncode({
        'username': username,
        'userMail': email,
      })
    );

    var json = jsonDecode(response.body);
  }

  static Future<Map<String, Object>> login(String user) async {
    var uriUrl = Uri.parse(loginUrl);
    var response = await http.post(
      uriUrl,
      headers: headers,
      body: jsonEncode({
        'user': user,
      })
    );
    var json = jsonDecode(response.body);

    return json;
  }
}
