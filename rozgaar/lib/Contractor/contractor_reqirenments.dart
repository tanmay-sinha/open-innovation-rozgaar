import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';

import 'resultDisplay.dart';

  

class contractor_requirenment extends StatefulWidget {
  @override
  _contractor_requirenmentState createState() =>
      _contractor_requirenmentState();
}

class _contractor_requirenmentState extends State<contractor_requirenment> {
  String _workHours;
  String _wage;
  String _numberOfLabours;
  final formKey = GlobalKey<FormState>();

  static const menuItems = <String>[
    'One',
    'Two',
    'Three',
    'Four',
  ];
  final List<DropdownMenuItem<String>> _dropDownMenuItems = menuItems
      .map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();
  final List<PopupMenuItem<String>> _popUpMenuItems = menuItems
      .map(
        (String value) => PopupMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();
  String _btn1SelectedVal = 'One';
  String _btn2SelectedVal;
  String _btn3SelectedVal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Requirements"),
      ),
      body: Container(
          padding: EdgeInsets.all(10.0),
          child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(height: 24.0),
                  TextFormField(
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      filled: true,
                      hintText: "number not more than 20",
                      labelText: "Number of Labour required",
                    ),
                    onSaved: (val) {
                      _numberOfLabours = val;
                    },
                  ),
                  // SizedBox(height: 24.0),
                  ListTile(
                    title: Text('Skills required:'),
                    trailing: DropdownButton(
                      value: _btn2SelectedVal,
                      hint: Text('Choose'),
                      onChanged: ((String newValue) {
                        setState(() {
                          _btn2SelectedVal = newValue;
                        });
                      }),
                      items: _dropDownMenuItems,
                    ),
                  ),
                  //SizedBox(height: 24.0),
                  TextFormField(
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      filled: true,
                      hintText: "INR",
                      labelText: "Wage per day",
                    ),
                    onSaved: (val) {
                      _wage = val;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      filled: true,
                      hintText: "Hours",
                      labelText: "Work hours required",
                    ),
                    onSaved: (val) {
                      _workHours = val;
                    },
                  ),
                  RaisedButton(
                      child: Text("Loacation"),
                      onPressed: () {
                   
                    },
                      )
                  ,
                  RaisedButton(
                      child: Text("Search"),
                      onPressed: () async {
                        formKey.currentState.save();
                        print(
                            'request generated, number of labour required is $_numberOfLabours , Workhour= $_workHours , wage offer= $_wage');
                        Map requirement_data = {
                          'number_of_labour_required': _numberOfLabours,
                          'work_hour': _workHours,
                          'wage_offer': _wage
                        };
                        var json_requirement_data =
                            jsonEncode(requirement_data);
                        print(json_requirement_data);
                        Response response = await post(
                          'http://httpbin.org/post',
                          body: json_requirement_data,
                        );
                        print(response.body);
                        print(response.statusCode);
                         Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  resultDisplay(response)));
                
                      })
                ],
              ))),
    );
  }
}
