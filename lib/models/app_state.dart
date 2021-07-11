import 'package:flutter/material.dart';
import 'package:genius_notes_mobile/models/notes.dart';
import 'package:genius_notes_mobile/models/profile.dart';

class AppState extends ChangeNotifier {
  AppState({this.profile, this.notes});

  Profile profile;
  Notes notes;

  setNotes(Notes newNotes) {
    notes = newNotes;
    notifyListeners();
  }
}