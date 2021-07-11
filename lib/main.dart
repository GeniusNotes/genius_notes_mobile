import 'package:flutter/material.dart';
import 'package:genius_notes_mobile/models/app_state.dart';
import 'package:genius_notes_mobile/models/notes.dart';
import 'package:genius_notes_mobile/models/profile.dart';
import 'package:genius_notes_mobile/pages/login_page.dart';
import 'package:genius_notes_mobile/pages/notes_page/notes_page.dart';
import 'package:genius_notes_mobile/services/local_storage.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var profile = await LocalStorage.getProfile()?? Profile();
  
  runApp(MyApp(profile: profile));
}

class MyApp extends StatelessWidget {
  MyApp({this.profile});

  final Profile profile;

  Widget _getFirstPage() {
    if (profile.username != null) {
      return NotesPage();
    }
    else {
      return LoginPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppState>.value(value: AppState(profile: profile, notes: Notes())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: _getFirstPage(),
      ),
    );
  }
}