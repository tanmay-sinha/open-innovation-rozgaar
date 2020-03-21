import 'dart:convert';
import 'package:rozgaar_app/labour_home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // Try running your application with "flutter run". You'll see the
//         // application has a blue toolbar. Then, without quitting the app, try
//         // changing the primarySwatch below to Colors.green and then invoke
//         // "hot reload" (press "r" in the console where you ran "flutter run",
//         // or simply save your changes to "hot reload" in a Flutter IDE).
//         // Notice that the counter didn't reset back to zero; the application
//         // is not restarted.
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }

class LabourLogin extends StatefulWidget {
  // MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  // final String title;

  @override
  _LabourLoginState createState() => _LabourLoginState();
}


class _LabourLoginState extends State<LabourLogin> {

  // TextEditingController _controller;

  // void initState() {
  //   super.initState();
  //   _controller = TextEditingController();
  // }

  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }

  // final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  String _email, _password;

  // String _data;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Rozgaar App'),
      ),
      resizeToAvoidBottomPadding: false,
      body: Container(

        padding: EdgeInsets.all(10.0),
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              
              TextFormField(
                // controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Enter your email containing @',
                  // border: InputBorder.none,
                  labelText: 'Email',
                ),
                validator: (val){
                  return val.contains('@') ? null : 'Email must contain @';
                },
                onSaved: (val){
                  _email = val;
                },
                // onFieldSubmitted: (String value){
                //   // _data = value;
                //   setState(() {
                //     // _data = value;
                //   });
                // },
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
                child: Text(
                  'Login',
                ),
                onPressed: () async{
                  // final form = formKey.currentState;
                  // if(form.validate()){
                  //   form.save();
                  //   print('Logged in, Email is $_email ; Password is $_password');
                    
                  // }
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
              

              // Text('$_data'),

            ],
          ),
        )

      ),
    );
  }
}
