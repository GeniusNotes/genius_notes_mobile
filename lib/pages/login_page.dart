import 'package:flutter/material.dart';
import 'package:genius_notes_mobile/models/app_state.dart';
import 'package:genius_notes_mobile/models/profile.dart';
import 'package:genius_notes_mobile/pages/code_verification_page.dart';
import 'package:genius_notes_mobile/pages/register_page.dart';
import 'package:genius_notes_mobile/pages/response_page.dart';
import 'package:genius_notes_mobile/services/api.dart';
import 'package:genius_notes_mobile/services/local_storage.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  String user;

  Future<Map<String, Object>> sendEmail() async {
    var result = await Api.login(user);
    return result;
  }

  void login(BuildContext context) async {
    var result = await Api.login(user);
    var appState = Provider.of<AppState>(context, listen: false);

    if (result['success']) {
      appState.profile = Profile(
        username: result['username'],
        email: result['mail']
      );

      LocalStorage.saveProfile(appState.profile);

      var newNotes = await Api.getNotes(appState.profile.username);
      appState.notes = newNotes;

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) {
            return CodeVerificationPage(
              username: result['username'],
              email: result['mail'],
              code: result['code'],
              onVerified: () {},
              sendAgain: sendEmail
            );
          }
        )
      );
    }
    else {
      // show error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        elevation: 0,
        centerTitle: true,
        toolbarHeight: 150,
        title: Container(
          height: 150,
          child: Image.asset('assets/icons/icon.png', fit: BoxFit.contain,)
        ),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Form(
                key: formKey,
                child: Column(
                  children: [
                    _loginField(),
                  ],
                )
              ),
              SizedBox(height: 50),
              _loginButton(context),
              _signUpButton(),
            ]
          ),
        ),
      ),
    );
  }

  Widget _loginField() {
    return TextFormField(
      cursorColor: Colors.black,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(color: Colors.black),
        ),
        labelText: "Your username or email",
        hintText: "geniusnotes.service@gmail.com",
      ),
      // inputFormatters: [phoneFormatter],
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) {
        formKey.currentState.validate();
      },
      onSaved: (String value) {
        user = value;
      },
    );
  }

  Widget _loginButton(BuildContext context) {
    return MaterialButton(
      color: Colors.black,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(41),
      ),
      minWidth: MediaQuery.of(context).size.width * 4/5,
      height: 46,
      onPressed: () {
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          login(context);
        }
      },
      child: Text(
        'Login',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _signUpButton() {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) {
              return RegisterPage();
            }
          )
        );
      }, 
      child: Text(
        'Not on GeniusNotes yet? Sign up',
        style: TextStyle(
          color: Colors.black
        ),
      )
    );
  }
}