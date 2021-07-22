import 'dart:async';

import 'package:flutter/material.dart';
import 'package:genius_notes_mobile/models/note.dart';
import 'package:genius_notes_mobile/services/api.dart';

class NotePage extends StatefulWidget {
  NotePage({this.note});

  final Note note;

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 30), (_) async {
      await Api.modifyNote(widget.note);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (FocusScope.of(context).hasFocus) {
          FocusScope.of(context).unfocus();
          // await Api.modifyNote(widget.note);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    initialValue: widget.note.title, 
                    style: TextStyle(
                      fontSize: 20
                    ),
                    onChanged: (value) {
                      widget.note.title = value;
                    },
                    maxLines: null,
                    textInputAction: TextInputAction.done,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    initialValue: widget.note.text,
                    decoration: InputDecoration.collapsed(hintText: 'your text'),
                    style: TextStyle(
                      fontSize: 16
                    ),
                    onChanged: (value) {
                      widget.note.text = value;
                    },
                    maxLines: null,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    Api.modifyNote(widget.note);
    _timer.cancel();
    super.dispose();
  }
}