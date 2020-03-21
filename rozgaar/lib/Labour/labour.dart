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
             //crossAxisAlignment: CrossAxisAlignment.center,
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ButtonBar(
                alignment: MainAxisAlignment.spaceAround,
                
                children: <Widget>[
                  
                  RaisedButton(
                    child: Text('Login'),
                    onPressed: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => LabourLogin()));
                    },
                  ),
                  RaisedButton(
                    child: Text('Register'),
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