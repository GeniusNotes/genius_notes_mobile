import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  final FocusNode passwordFocusNode = FocusNode();

  String login;

  String password;

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
          child: Image.asset('assets/icons/icon.png',fit: BoxFit.contain,)
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
                    _passwordField(),
                  ],
                )
              ),
              SizedBox(height: 50),
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
        labelText: "Your login",
        hintText: "",
      ),
      // inputFormatters: [phoneFormatter],
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) {
        formKey.currentState.validate();
        FocusScope.of(context).requestFocus(passwordFocusNode);
      },
      onSaved: (String value) {
        login = value;
      },
    );
  }

  Widget _passwordField() {
    return TextFormField(
      focusNode: passwordFocusNode,
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
        labelText: "Password",
        hintText: "",
      ),
      obscureText: true,
      onSaved: (String value) {
        password = value;
      },
    );
  }

  Widget _loginButton() {
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
          // login();
        }
      },
      child: Text(
        'Sign up / Login',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}