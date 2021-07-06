import 'package:flutter/material.dart';
import 'package:genius_notes_mobile/pages/response_page.dart';

class CodeVerificationPage extends StatefulWidget {
  const CodeVerificationPage({this.username, this.email, this.code, this.onVerified, this.sendAgain});

  final String username;
  final String email;
  final String code;
  final Function onVerified;
  final Future<Map<String, Object>> Function() sendAgain;

  @override
  _CodeVerificationPageState createState() => _CodeVerificationPageState(code: code);
}

class _CodeVerificationPageState extends State<CodeVerificationPage> {
  _CodeVerificationPageState({this.code});

  final formKey = GlobalKey<FormState>();
  String code;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Text("We've sent a code to ${widget.email}.\nEnter it below", textAlign: TextAlign.center,),
              SizedBox(height: 20),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    _codeField()
                  ],
                )
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () async {
                  var result = await widget.sendAgain.call();

                  if (result['success']) {
                    code = result['code'];
                  }
                  else {
                    // show error, return back
                  }
                }, 
                child: Text(
                  'Send again',
                  // style: TextStyle(
                  //   color: Colors.black
                  // ),
                )
              ),
            ]
          )
        )
      ),
    );
  }

  Widget _codeField() {
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
        labelText: "Code",
        hintText: "",
      ),
      // inputFormatters: [phoneFormatter],
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (_) {
        if (formKey.currentState.validate()) {
          widget.onVerified.call();

          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => ResponsePage(message: "Success, ${widget.username}")),
            (route) => false
          );
        }
      },
      validator: (value) {
        return value == widget.code? null: 'wrong code';
      },
    );
  }
}