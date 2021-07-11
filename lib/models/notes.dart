import 'package:flutter/cupertino.dart';
import 'package:genius_notes_mobile/models/note.dart';

class Notes extends ChangeNotifier{
  Notes({this.personalNotes = const[]});

  List<Note> personalNotes;
}