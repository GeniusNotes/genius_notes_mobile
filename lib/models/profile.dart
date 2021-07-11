import 'package:flutter/cupertino.dart';

class Profile extends ChangeNotifier{
  Profile({this.username, this.email});

  String username;
  String email;

  factory Profile.fromJson(Map<String, Object> json) {
    return Profile(
      email: json['email'],
      username: json['username']
    );
  }

  Map<String, Object> toJson() {
    return {
      'email': email,
      'username': username
    };
  }
}