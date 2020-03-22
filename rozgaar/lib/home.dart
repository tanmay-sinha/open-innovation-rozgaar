import 'package:flutter/material.dart';
// import 'contractor_login.dart';
import 'Contractor/contractor_login.dart';
import 'Labour/labour.dart';
// import 'labour.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      appBar: new AppBar(
        title: Container(
          child:Text(
            'Home',
            style:TextStyle(fontSize: 25, color: Colors.white)
          )
        ),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.home), onPressed: () {}),
        ],
      ),
      body: Container(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
              color: Color.fromARGB(250, 252, 108, 35),
              margin: EdgeInsets.all(20.0),
              elevation: 0.0,
              child: Container(
                height: 100.0,
                child: InkWell(
                  splashColor: Colors.black45,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Labour()),
                    );
                  },
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          'Labour',
                          style: TextStyle(fontSize: 40, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              color: Color.fromARGB(250, 35, 63, 126),
              margin: EdgeInsets.all(20.0),
              elevation: 0.0,
              child: Container(
                height: 100.0,
                child: InkWell(
                  splashColor: Colors.black45,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ContractorLogin()),
                    );
                  },
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          'Contractor',
                          style: TextStyle(fontSize: 40, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
