import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'contractor_reqirenments.dart';
import 'Contractor_register.dart';

class ContractorLogin extends StatefulWidget {
  @override
  _ContractorLoginState createState() => _ContractorLoginState();
}

class _ContractorLoginState extends State<ContractorLogin> {
  final GlobalKey<FormFieldState<String>> _passwordFieldKey =
      new GlobalKey<FormFieldState<String>>();
  String _id;
  String _password;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Contractor Login"),
      ),
      body: new Container(
        padding: EdgeInsets.all(10.0),
        child: Form(
            key: formKey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 24.0),
                  TextFormField(
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      filled: true,
                      icon: Icon(Icons.person),
                      hintText: "Your ID",
                      labelText: 'ID',
                    ),
                    onSaved: (String value) {
                      _id = value;
                    },
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  PasswordField(
                    fieldKey: _passwordFieldKey,
                    helperText: 'No more than 8 characters.',
                    labelText: 'Password *',
                    onSaved: (String value) {
                      _password = value;
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  RaisedButton(
                    textColor: Colors.white,
                    color: Colors.lightBlue,
                    padding: EdgeInsets.fromLTRB(9, 9, 9, 9),
                    splashColor: Colors.grey,
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 18.0
                      ),
                    ),
                    onPressed: () async {
                      formKey.currentState.save();
                      print("Request generated $_id $_password");
                      Map loginData = {'id': _id, 'password': _password};
                      var jsonLoginData = jsonEncode(loginData);
                      print(jsonLoginData);
                      Response response = await post(
                        'http://httpbin.org/post',
                        body: jsonLoginData,
                      );
                      print(response.body);
                      print(response.statusCode);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ContractorRequirenment()));
                    },
                  ),
                  SizedBox(height: 15.0),
                  Text(
                    "or",
                    style: TextStyle(fontSize: 22.0),
                  ),
                  SizedBox(height: 15.0),
                  RaisedButton(
                    textColor: Colors.white,
                    color: Colors.lightBlue,
                    padding: EdgeInsets.fromLTRB(9, 9, 9, 9),
                    splashColor: Colors.grey,
                    child: Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 18.0
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ContractorRegistration()));
                    },
                  ),
                ])),
      ),
    );
  }
}

class PasswordField extends StatefulWidget {
  const PasswordField({
    this.fieldKey,
    this.hintText,
    this.labelText,
    this.helperText,
    this.onSaved,
    this.validator,
    this.onFieldSubmitted,
  });
  final Key fieldKey;
  final String hintText;
  final String labelText;
  final String helperText;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;

  @override
  _PasswordFieldState createState() => new _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return new TextFormField(
      key: widget.fieldKey,
      obscureText: _obscureText,
      maxLength: 8,
      onSaved: widget.onSaved,
      validator: widget.validator,
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: new InputDecoration(
        border: const UnderlineInputBorder(),
        filled: true,
        hintText: widget.hintText,
        labelText: widget.labelText,
        helperText: widget.helperText,
        suffixIcon: new GestureDetector(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child:
              new Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
        ),
      ),
    );
  }
}
