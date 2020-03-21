import 'dart:convert';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:http/http.dart';

import 'resultDisplay.dart';

class ContractorRequirenment extends StatefulWidget {
  @override
  _ContractorRequirenmentState createState() => _ContractorRequirenmentState();
}

class _ContractorRequirenmentState extends State<ContractorRequirenment> {
  String _workHours;
  String _wage;
  String _numberOfLabours;
  final formKey = GlobalKey<FormState>();

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

  String _btn1SelectedVal;

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
                      value: _btn1SelectedVal,
                      hint: Text('Choose'),
                      onChanged: ((String newValue) {
                        setState(() {
                          _btn1SelectedVal = newValue;
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
                    onPressed: () {},
                  ),
                  RaisedButton(
                      child: Text("Search"),
                      onPressed: () async {
                        formKey.currentState.save();
                        print(
                            'request generated, number of labour required is $_numberOfLabours , Workhour= $_workHours , wage offer= $_wage');
                        Map requirementData = {
                          'number_of_labour_required': _numberOfLabours,
                          'work_hour': _workHours,
                          'wage_offer': _wage,
                          'job_choice': _btn1SelectedVal,
                        };
                        var jsonRequirementData = jsonEncode(requirementData);
                        print(jsonRequirementData);
                        Response response = await post(
                          "http://192.168.43.43:5000/get_details",
                      headers: {
                        "accept":"application/json",
                        "content-type":"application/json",
                      },
                      body: jsonRequirementData,
                        );
                        print(response.body);
                        print(response.statusCode);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ResultDisplay(response)));
                      })
                ],
              ))),
    );
  }
}
