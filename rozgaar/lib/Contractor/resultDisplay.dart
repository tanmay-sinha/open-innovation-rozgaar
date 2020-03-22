import 'package:flutter/material.dart';

class ResultDisplay extends StatefulWidget {
  var response;
  ResultDisplay(this.response);
  @override
  _ResultDisplayState createState() => _ResultDisplayState();
}

class _ResultDisplayState extends State<ResultDisplay> {
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
