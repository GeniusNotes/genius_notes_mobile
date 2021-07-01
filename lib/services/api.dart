import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:genius_notes_mobile/models/profile.dart';
import 'package:http/http.dart' as http;

class Api {
  static const baseUrl = 'https://genius-notes.herokuapp.com/';
  static const registerUrl = baseUrl + 'register';
  static const loginUrl = baseUrl + 'login';
  static const logoutUrl = baseUrl + 'logout';
  static var dio = Dio();
  // static const headers = {
  //   'accept': 'application/json',
  //   'Content-Type': 'application/json'
  // };

  static Future<Profile> register(String username, String password) async {
    FormData formData = FormData.fromMap({'username': username, 'password': password});
    var response = await dio.post(registerUrl, data: formData, options: Options(responseType: ResponseType.json, contentType: 'application/json'));
    var json = response.data;

    return json['success']? Profile(username: json['username']) : null;
  }

  static Future<Profile> login(String username, String password) async {
    // var uriUrl = Uri.parse(loginUrl);
    // var response = await http.post(
    //   uriUrl,
    //   // headers: headers,
    //   body: jsonEncode({
    //     'username': username,
    //     'password': password,
    //   })
    // );
    // var json = jsonDecode(response.body);

    FormData formData = FormData.fromMap({'username': username, 'password': password});
    var response = await dio.post(loginUrl, data: formData, options: Options(responseType: ResponseType.json, contentType: 'application/json'));
    var json = response.data;

    return json['success']? Profile(username: json['username']) : null;
  }
}
