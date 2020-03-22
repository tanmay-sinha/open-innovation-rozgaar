import 'package:flutter/material.dart';
import 'package:rozgaar/Labour/labour_register.dart';
import 'package:rozgaar/Labour/labour_login.dart';

class Labour extends StatelessWidget {
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Card(
              color: Color.fromARGB(250, 35, 63, 126),
              margin: EdgeInsets.all(20.0),
              elevation: 0.0,
              child: Container(
                height: 100.0,
                child: InkWell(
                  splashColor: Colors.black45,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LabourRegister()),
                    );
                  },
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          'Register',
                          style: TextStyle(fontSize: 40, color: Colors.white),
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
