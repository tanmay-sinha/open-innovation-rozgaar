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
      body: Container(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
              color: Colors.teal,
              margin: EdgeInsets.all(20.0),
              elevation: 0.0,
              child: Container(
                height: 100.0,
                child: InkWell(
                  splashColor: Colors.black45,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Labour()),
                    );
                  },
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          'Labour',
                          style: TextStyle(fontSize: 40),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              color: Colors.teal,
              margin: EdgeInsets.all(20.0),
              elevation: 0.0,
              child: Container(
                height: 100.0,
                child: InkWell(
                  splashColor: Colors.black45,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ContractorLogin()),
                    );
                  },
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          'Contractor',
                          style: TextStyle(fontSize: 40),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
