import 'dart:convert';
import 'package:rozgaar/Labour/labour_home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class LabourLogin extends StatefulWidget {
  @override
  _LabourLoginState createState() => _LabourLoginState();
}


class _LabourLoginState extends State<LabourLogin> {

  final formKey = GlobalKey<FormState>();

  String _email, _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rozgaar App'),
      ),
      resizeToAvoidBottomPadding: false,
      body: Container(

        padding: EdgeInsets.fromLTRB(10.0, 200.0, 10.0, 50.0),
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[       
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Enter your email containing @',
                  labelText: 'Email',
                ),
                validator: (val){
                  return val.contains('@') ? null : 'Email must contain @';
                },
                onSaved: (val){
                  _email = val;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password more than 6 characters',
                ),
                validator: (val){
                  return val.length >= 6 ? null : 'Password must contain more than 6 characters';
                },
                obscureText: true,
                onSaved: (val){
                  _password = val;
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              RaisedButton(
                textColor: Colors.white,
                color: Colors.lightBlue,
                padding: EdgeInsets.fromLTRB(9, 9, 9, 9),
                splashColor: Colors.grey,
                child: Text(
                  'Login',
                ),
                onPressed: () async{
                  if(formKey.currentState.validate()){
                    formKey.currentState.save();
                    print('Logged in, Email is $_email ; Password is $_password');
                    Map data = {
                      'email' : _email,
                      'password' : _password
                    };
                    var jsonData = jsonEncode(data);
                    print(jsonData);
                    Response response = await post(
                      'http://httpbin.org/post',
                      body: jsonEncode(data),
                    );
                    print(response.body);
                    print(response.statusCode);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LabourHome(response)),
                    );
                  }
                },
              )
            ],
          ),
        )

      ),
    );
  }
}
