import 'package:flutter/material.dart';

class SelectSkillsLabour extends StatefulWidget {
  @override
  _SelectSkillsLabourState createState() => _SelectSkillsLabourState();
}

class _SelectSkillsLabourState extends State<SelectSkillsLabour> {

  Map<String, bool> skills = {
    'Woodwork' : false,
    'Masonry' : false,
    'Painting' : false,
  };
  var tempSkills = [];

  getCheckBoxItems(){
    skills.forEach((key, value){
      if(value == true){
        tempSkills.add(key);
      }
    });
    // print(tempSkills);
    Navigator.pop(context, tempSkills);
    // tempSkills.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select skills'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text(
                'Submit selected checkbox items',
              ),
              onPressed: getCheckBoxItems,
            ),
            Expanded(
              child: ListView(
                children: skills.keys?.map((String key){
                  return CheckboxListTile(
                    title: Text(key),
                    value: skills[key],
                    onChanged: (bool val){
                      setState(() {
                        skills[key] = val;
                      });
                    },
                  );
                })?.toList() ?? [],
              ),
            ),
          ],
        ),
      ),
    );
  }
}