import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ContractorRegistration extends StatefulWidget {
  @override
  _ContractorRegistrationState createState() =>
      _ContractorRegistrationState();
}

class _ContractorRegistrationState extends State<ContractorRegistration> {
  String _name, _phone;

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

              SizedBox(
                height: 10.0,
              ),

              RaisedButton(
                textColor: Colors.white,
                color: Colors.lightBlue,
                padding: EdgeInsets.fromLTRB(9, 9, 9, 9),
                splashColor: Colors.grey,
                child: Text(
                  'Submit',
                  style: TextStyle(
                    fontSize: 18.0
                  ),
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    print('Registration successful');
                    Map data = {
                      'name': _name,
                      'phone': _phone,
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
            ],
          ),
        ),
      ),
    );
  }
}
