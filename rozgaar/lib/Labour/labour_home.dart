import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class LabourHome extends StatefulWidget {

  Response data;
  LabourHome(this.data);

  @override
  _LabourHomeState createState() => _LabourHomeState(this.data);
}

class _LabourHomeState extends State<LabourHome> {

  Response data;
  _LabourHomeState(this.data);
  bool hasWork = false;
  bool hasDenied = false;
  bool hasAccepted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Labour Home'
        ),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh), onPressed: () async {
            Response response = await get(
              'http://httpbin.org/json',  //api endpoint for getting json response from server
            );
            print(response.body);
            setState(() {
              // If response contains info that work is alloted, then set hasWork to true
              data = response;
              print(data.body);
            });
          }),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Text(
              '${jsonDecode(data.body)}'  //Show the allotted work if any here, also the location in text field below
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  child: Text('Accept'),
                  onPressed: hasDenied || hasAccepted ? null : (){
                    // print(jsonDecode(data.body)['json']['email']);
                    // send request to server to accept database in form of json
                    setState(() {
                      // Accept when previously not accepted 
                      hasAccepted = true;
                    });
                  },
                ),
                SizedBox(
                  width: 5.0,
                ),
                RaisedButton(
                  child: Text('Deny'),
                  onPressed: hasDenied ? null : () {
                    // print(jsonDecode(data.body)['json']['email']);
                    // send request to server to update database in form of json
                    setState(() {
                      // Deny when previously not denied
                      hasDenied = true;
                      hasAccepted = false;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}