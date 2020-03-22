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
        title: Text("Best results for your search!"),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.only(top: 32.0, bottom: 32.0, left: 16.0, right: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    response[index].title,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    response[index].text,
                    style: TextStyle(
                      color: Colors.grey.shade600
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: response.length,
      )
    );
  }
}
