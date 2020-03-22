import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:rozgaar/Labour/labour_login.dart';
import 'package:rozgaar/get_location.dart';

class LabourRegister extends StatefulWidget {
  @override
  _LabourRegisterState createState() => _LabourRegisterState();
}

class _LabourRegisterState extends State<LabourRegister> {
  String _name, _gender;
  Map<String, double> _location = {
    'latitude': 0.0,
    'longitude': 0.0,
  };
  int _age;
  String _contact_no;
  String skill = "";

  final _formKey = GlobalKey<FormState>();

  static const menuItems = <String>[
    'Carpentry',
    'Painting',
    'Masonry',
    'Plumbing',
    'Electrician',
    'Cleaner',
    'Rigger',
    'Transport',
    'Welder',
    'Fitter',
  ];
  final List<DropdownMenuItem<String>> _dropDownMenuItems = menuItems
      .map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();

  String _skill;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register yourself'),
      ),
      resizeToAvoidBottomPadding: false,
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
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
                  labelText: 'Gender',
                ),
                validator: (val) {
                  if (val.isEmpty) {
                    return 'Gender cannot be empty';
                  }
                  return null;
                },
                onSaved: (val) {
                  _gender = val;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Contact number',
                ),
                validator: (val) {
                  if (val.length != 10) {
                    return 'Must be a 10 digit number';
                  }
                  return null;
                },
                onSaved: (val) {
                  _contact_no = val;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Age',
                ),
                validator: (val) {
                  int age = int.tryParse(val);
                  if (age == null || age < 0) {
                    return 'Age cannot be empty or negative';
                  }
                  return null;
                },
                onSaved: (val) {
                  int age = int.tryParse(val);
                  _age = age;
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    'Latitude: ${_location['latitude']} Longitude: ${_location['longitude']}',
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  RaisedButton(
                    textColor: Colors.white,
                    color: Colors.lightBlue,
                    padding: EdgeInsets.fromLTRB(9, 9, 9, 9),
                    splashColor: Colors.grey,
                    child: Text(
                      'Get location',
                      style: TextStyle(fontSize: 14.0),
                    ),
                    onPressed: () {
                      FetchLocation().returnLocation().then((result) {
                        print(result);
                        setState(() {
                          _location = result;
                        });
                      });
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              ListTile(
                title: Text('Skill :'),
                trailing: DropdownButton(
                  value: _skill,
                  hint: Text('Choose'),
                  onChanged: ((String newValue) {
                    setState(() {
                      _skill = newValue;
                    });
                  }),
                  items: _dropDownMenuItems,
                ),
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
                    fontSize: 18.0,
                  ),
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    print('Registration successful');
                    Map data = {
                      'name': _name,
                      'age': _age,
                      'gender': _gender,
                      'location': _location,
                      'skills': _skill,
                      'contact': _contact_no,
                    };
                    var jsonData = jsonEncode(data);
                    Response response = await post(
                      "http://192.168.43.43:5000/add_database",
                      headers: {
                        "accept": "application/json",
                        "content-type": "application/json",
                      },
                      body: jsonData,
                    );
                    print(response.body);
                    print(response.statusCode);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LabourLogin()),
                    );
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
