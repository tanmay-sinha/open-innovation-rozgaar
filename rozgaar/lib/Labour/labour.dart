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
              ButtonBar(
                alignment: MainAxisAlignment.spaceAround,
                
                children: <Widget>[
                  RaisedButton(
                    textColor: Colors.white,
                    color: Colors.lightBlue,
                    padding: EdgeInsets.fromLTRB(9, 9, 9, 9),
                    splashColor: Colors.grey,
                    child: Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => LabourRegister()));
                    },
                  ),
                ],
              ),
            ]),
      ),
    )
    );
  }
}