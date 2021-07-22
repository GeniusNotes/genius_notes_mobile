import 'package:flutter/material.dart';
import 'package:genius_notes_mobile/models/app_state.dart';
import 'package:genius_notes_mobile/models/notes.dart';
import 'package:genius_notes_mobile/pages/note_page/note_page.dart';
import 'package:genius_notes_mobile/services/api.dart';
import 'package:provider/provider.dart';

class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  Future updateNotes(AppState appState) async {
    var newNotes = await Api.getNotes(appState.profile.username);
    appState.setNotes(newNotes);
    print(appState.notes.personalNotes);

    setState(() {
      notes = newNotes;
    });
  }

  Notes notes = Notes(personalNotes: []);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async { 
      var appState = Provider.of<AppState>(context, listen: false);
      await updateNotes(appState);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          var appState = Provider.of<AppState>(context, listen: false);
          await updateNotes(appState);
        },
        child: Container(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: ListView(
              children: <Widget>[SizedBox(height: 10)] + notes.personalNotes.map((note) {
                return Padding(
                  padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                        return NotePage(note: note);
                      }));
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      width: MediaQuery.of(context).size.width * 9 / 10,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.all(Radius.circular(5))
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(note.title, style: TextStyle(fontWeight: FontWeight.bold),),
                          Text(note.text, overflow: TextOverflow.ellipsis, maxLines: 1,)
                        ]
                      ),
                    ),
                  ),
                );
              }).toList()
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          var appState = Provider.of<AppState>(context, listen: false);
          await Api.createNote(appState.profile.username);
          await updateNotes(appState);
        }
      ),
    );
  }
}