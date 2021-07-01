import 'package:flutter/material.dart';

class ResponsePage extends StatelessWidget {
  ResponsePage({this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Center(
        child: Column(
          children: [
            Spacer(flex: 2),
            Text(
              message,
              style: TextStyle(
                fontSize: 20
              ),
            ),
            Spacer(flex: 3)
          ],
        ),
      ),
    );
  }
}