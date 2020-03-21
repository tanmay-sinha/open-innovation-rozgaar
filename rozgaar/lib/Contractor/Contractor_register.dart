import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'contractor_login.dart';

class contractor_registration extends StatefulWidget {
  @override
  _contractor_registrationState createState() =>
      _contractor_registrationState();
}

class _contractor_registrationState extends State<contractor_registration> {
  String _name, _phone, _location;
  int _age;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contractor Registration'),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 24.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
                validator: (val) {
                  if (val.isEmpty) {
                    return 'Name cannot be empty';
                  }
                  return null;
                },
                onSaved: (val) {
                  _name = val;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Phone number',
                ),
                validator: (val) {
                  if (val.length != 10) {
                    return 'Must contain 10 digits';
                  }
                  return null;
                },
                onSaved: (val) {
                  _phone = val;
                },
              ),

              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Location',
                ),
                validator: (val) {
                  if (val.isEmpty) {
                    return 'Location cannot be empty';
                  }
                  return null;
                },
                onSaved: (val) {
                  _location = val;
                },
              ),
              SizedBox(
                height: 10.0,
              ),

              RaisedButton(
                child: Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    print('Registration successful');
                    Map data = {
                      'name': _name,
                      'phone': _phone, //**************
                      'location': _location,
                    };
                    var jsonData = jsonEncode(data);
                    Response response = await post(
                      'http://httpbin.org/post',
                      body: jsonData,
                    );
                    print(response.body);
                    print(response.statusCode);
                    Navigator.pop(context);
                  }
                },
              )
              // ,SizedBox(height: 24,)
            ],
          ),
        ),
      ),
    );
  }
}
