import 'package:flutter/material.dart';

class ResultDisplay extends StatefulWidget {
  var response;
  ResultDisplay(this.response);
  @override
  _ResultDisplayState createState() => _ResultDisplayState(this.response);
}

class _ResultDisplayState extends State<ResultDisplay> {
  var response;
  _ResultDisplayState(this.response);

  // var notesJson = json.decode(response);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("responses"),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 32.0, bottom: 32.0, left: 16.0, right: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      response[index]["name"].toString(),
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "age: " + response[index]["age"].toString(),
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                    Text(
                      "gender: " + response[index]["gender"].toString(),
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                    Text(
                      "distance: " +
                          response[index]["distance"].toString() +
                          " km",
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                    Text(
                      "contact no. " + response[index]["contact"].toString(),
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
            );
          },
          itemCount: response.length,
        ));
  }
}
