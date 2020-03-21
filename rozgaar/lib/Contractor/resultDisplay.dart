import 'package:flutter/material.dart';

class resultDisplay extends StatefulWidget {
  var response;
  resultDisplay(var x) {
    this.response = x;
  }
  @override
  _resultDisplayState createState() => _resultDisplayState();
}

class _resultDisplayState extends State<resultDisplay> {
  var response;
  resultDisplay(var x) {
    this.response = x;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("responses"),
      ),
      
      body: Container(
        child: Text("$response"),
      ),
    );
  }
}
