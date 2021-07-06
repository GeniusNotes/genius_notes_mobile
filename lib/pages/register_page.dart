import 'package:flutter/material.dart';
import 'package:genius_notes_mobile/pages/code_verification_page.dart';
import 'package:genius_notes_mobile/pages/login_page.dart';
import 'package:genius_notes_mobile/pages/response_page.dart';
import 'package:genius_notes_mobile/services/api.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();

  final FocusNode emailFocusNode = FocusNode();
  String username;
  String email;

  Future<Map<String, Object>> sendEmail() async {
    var result = await Api.register(username, email);
    return result;
  }

  void register() async {
    var result = await Api.register(username, email);
    if (result['success']) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) {
            return CodeVerificationPage(
              username: result['username'],
              email: result['mail'],
              code: result['code'],
              onVerified: () async {
                await Api.createUser(username, email);
              },
              sendAgain: sendEmail,
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
                    SizedBox(height: 30),
                    _emailField(),
                  ],
                )
              ),
              SizedBox(height: 50),
              _registerButton(),
              _loginButton()
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
        labelText: "Your username",
        hintText: "",
      ),
      // inputFormatters: [phoneFormatter],
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) {
        formKey.currentState.validate();
        FocusScope.of(context).requestFocus(emailFocusNode);
      },
      onSaved: (String value) {
        username = value;
      },
    );
  }

  Widget _emailField() {
    return TextFormField(
      focusNode: emailFocusNode,
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
        labelText: "Email",
        hintText: "geniusnotes.service@gmail.com",
      ),
      onSaved: (String value) {
        email = value;
      },
    );
  }

  Widget _registerButton() {
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
          register();
        }
      },
      child: Text(
        'Sign up',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _loginButton() {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) {
              return LoginPage();
            }
          )
        );
      }, 
      child: Text(
        'Already have an account? Login',
        style: TextStyle(
          color: Colors.black
        ),
      )
    );
  }
}