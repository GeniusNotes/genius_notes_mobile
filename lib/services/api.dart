import 'dart:convert';

import 'package:genius_notes_mobile/models/note.dart';
import 'package:genius_notes_mobile/models/notes.dart';
import 'package:http/http.dart' as http;

class Api {
  static const baseUrl = 'https://genius-notes.herokuapp.com/';
  static const registerUrl = baseUrl + 'register';
  static const loginUrl = baseUrl + 'login';
  static const createUserUrl = baseUrl + 'createUser';
  static const getNotesUrl = baseUrl + 'getNotes';
  static const createNoteUrl = baseUrl + 'createNote';
  static const modifyNoteUrl = baseUrl + 'modifyNote';
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

  static Future<Notes> getNotes(String username) async {
    var uriUrl = Uri.parse(getNotesUrl);
    var response = await http.post(
      uriUrl,
      headers: headers,
      body: jsonEncode({
        'username': username,
      })
    );
    var json = jsonDecode(response.body);

    print('get Notes');
    print(json);

    var personalNotes = (json['notes'] as List<dynamic>).map((objectJson) => Note.fromJson(jsonDecode(objectJson))).toList();
    return Notes(personalNotes: personalNotes);
  }

  static Future createNote(String username) async {
    var uriUrl = Uri.parse(createNoteUrl);
    var response = await http.post(
      uriUrl,
      headers: headers,
      body: jsonEncode({
        'username': username,
      })
    );

    var json = jsonDecode(response.body);
  }

  static Future modifyNote(Note note) async {
    var uriUrl = Uri.parse(modifyNoteUrl);
    var response = await http.post(
      uriUrl,
      headers: headers,
      body: jsonEncode(note.toJson())
    );

    print(note.toJson());

    // var json = jsonDecode(response.body);
  }
}
