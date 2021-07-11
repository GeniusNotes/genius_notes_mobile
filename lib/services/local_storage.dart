import 'dart:convert';

import 'package:genius_notes_mobile/models/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static Future<Profile> getProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var profileJson = prefs.getString('profile') ?? null;

    if (profileJson != null) {
      var json = jsonDecode(profileJson);
      var profile = Profile.fromJson(json);
      return profile;
    }
    else {
      return null;
    }
  }

  static void saveProfile(Profile profile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('profile', jsonEncode(profile.toJson()));
  }
}