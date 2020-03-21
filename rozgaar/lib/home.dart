import 'package:flutter/material.dart';
// import 'contractor_login.dart';
import 'Contractor/contractor_login.dart';
import 'Labour/labour.dart';
// import 'labour.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      appBar: new AppBar(
        title: Text("Home"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.home), onPressed: () {}),
        ],
      ),
      body: new Container(
        child: new Column(
            //crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ButtonBar(
                alignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  RaisedButton(
                    child: Text('Labour'),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Labour()));
                    },
                  ),
                  RaisedButton(
                    child: Text('Contractor'),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => contractorLogin()));
                    },
                  ),
                ],
              ),
            ]),
      ),
    ));
  }
}
