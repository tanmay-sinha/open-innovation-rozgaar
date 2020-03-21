import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:rozgaar/Labour/labour_login.dart';
import 'package:rozgaar/Labour/labour_select_skills.dart';
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
  List _skills = [];
  int _age;
  String skill = "";

  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

    // Labour labour = Labour();
    // Labour labour;

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
                validator: (val){
                  if(val.isEmpty){
                    return 'Name cannot be empty';
                  }
                  return null;
                },
                onSaved: (val){
                  _name = val;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Gender',
                ),
                validator: (val){
                  if(val.isEmpty){
                    return 'Gender cannot be empty';
                  }
                  return null;
                },
                onSaved: (val){
                  _gender = val;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Age',
                ),
                validator: (val){
                  int age = int.tryParse(val);
                  if(age == null || age < 0){
                    return 'Age cannot be empty or negative';
                  }
                  return null;
                },
                onSaved: (val){
                  int age = int.tryParse(val);
                  _age = age;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    child: Text(
                      'Get location',
                    ),
                    onPressed: (){
                      // var response =  FetchLocation().returnLocation();
                      // setState(() {
                      //   _location = response;
                      // });
                      FetchLocation().returnLocation().then((result) {
                        print(result);
                        setState(() {
                          _location = result;
                        });
                      });
                    },
                  ),
                  SizedBox(
                    width: 50.0,
                  ),
                  Text(
                    'Latitude: ${_location['latitude']} Longitude: ${_location['longitude']}',
                  ),
                ],
              ),
              // TextFormField(
              //   decoration: InputDecoration(
              //     labelText: 'Location',
              //   ),
              //   validator: (val){
              //     if(val.isEmpty){
              //       return 'Location cannot be empty';
              //     }
              //     return null;
              //   },
              //   onSaved: (val){
              //     _location = val;
              //   },
              // ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    'Skills selected: ',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  // Text(
                  //   '$skill',
                  // ),
                  Row(
                    children: _skills?.map((skill)  {
                      return Container(
                        child: Text(
                          '$skill ',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      );
                    })?.toList() ?? [],
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              RaisedButton(
                child: Text(
                  'Select your skills'
                ),
                onPressed: () async{
                  // await skillSelection(context);
                  var result = await Navigator.push(
                    context, MaterialPageRoute(builder: (context) => SelectSkillsLabour()));
                  
                  if(result == null){
                    result = [];
                  }
                  print(result);
                  _skills = result;
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
                  if(_formKey.currentState.validate()){
                    _formKey.currentState.save();
                    print('Registration successful');
                    Map data = {
                      'name' : _name,
                      'age' : _age,
                      'gender' : _gender,
                      'location' : _location,
                      'skills' : _skills,
                    };
                    var jsonData = jsonEncode(data);
                    Response response = await post(
                      'http://127.0.0.1:5000/add_database/post',
                      // 'http://httpbin.org/post',
                      body: jsonData,
                    );
                    print(response.body);
                    print(response.statusCode);
                    Navigator.push(
                      context, MaterialPageRoute(builder: (context) => LabourLogin()),
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

// void skillSelection(BuildContext  context){
//   var alertDialog = AlertDialog(
//     title: Text(
//       'Select skills',
//     ),
//     actions: <Widget>[
//       Text('Cancel'),
//       Text('OK'),
//     ],
//     content: Column(
//       children: <Widget>[
//         Row(
//           children: <Widget>[
//             Checkbox(
//               value: false, 
//               onChanged: (bool val){
//                 print(val);
//                 setState(){

//                 };
//             }),
//             Text(
//               'Woodwork'
//             ),
//           ],
//         ),
//         Row(
//           children: <Widget>[
//             Text(
//               'Masonry'
//             ),
//           ],
//         ),
//       ],
//     ),
//   );
//   showDialog(
//     context: context,
//     builder: (BuildContext context){
//       return alertDialog;
//     }
//   );
// }