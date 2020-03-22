import 'package:flutter/material.dart';

class LabourLogin extends StatefulWidget {
  @override
  _LabourLoginState createState() => _LabourLoginState();
}


class _LabourLoginState extends State<LabourLogin> {

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rozgaar App'),
      ),
      resizeToAvoidBottomPadding: false,
      body: Container(

        padding: EdgeInsets.fromLTRB(10.0, 200.0, 10.0, 50.0),
        child: Text(
          'You have successfully registered',
          style: TextStyle(
            fontSize: 30.0,
          ),
        ),

      ),
    );
  }
}
