import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:studentresourceapp/pages/signin.dart';
import 'package:studentresourceapp/utils/contstants.dart';

class UserDetailGetter extends StatefulWidget {
  @override
  _UserDetailGetterState createState() => _UserDetailGetterState();
}

class _UserDetailGetterState extends State<UserDetailGetter> {
  String college;
  int batch;
  String branch;
  int semester;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              color: Colors.grey,
              child: Column(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Institute',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 30,
                        color: Colors.purple),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: Constants.kTextFieldDecoration
                        .copyWith(hintText: 'IIITA'),
                    keyboardType: TextInputType.multiline,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      setState(() {
                        college = value.toUpperCase();
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Batch',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 30,
                        color: Colors.purple),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: Constants.kTextFieldDecoration
                        .copyWith(hintText: '2019, 2020'),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      setState(() {
                        batch = int.parse(value);
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Branch',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 30,
                        color: Colors.purple),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: Constants.kTextFieldDecoration
                        .copyWith(hintText: 'IT, ECE, ITBI'),
                    keyboardType: TextInputType.multiline,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      setState(() {
                        branch = value.toUpperCase();
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Semester',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 30,
                        color: Colors.purple),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: Constants.kTextFieldDecoration
                        .copyWith(hintText: '1, 2, 3, 4, 5, 6, 7, 8'),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      setState(() {
                        semester = int.parse(value);
                      });
                    },
                  ),
                ),
                RaisedButton(
                    child: Text('Proceed'),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return SignIn(
                                college: college,
                                batch: batch,
                                branch: branch,
                                semester: semester);
                          },
                        ),
                      );
                    })
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

/*  DropDownFormField(
            titleText: 'Institute',
            hintText: 'Please choose one',
            value: college,
            onSaved: (value) {
              setState(() {
                college = value;
              });
            },
            onChanged: (value) {
              setState(() {
                college = value;
              });
            },
            dataSource: [
              {
                "display": "IIITA",
                "value": "IIITA",
              },
              {
                "display": "Others",
                "value": "Others",
              },
            ],
            textField: 'display',
            valueField: 'value',
          ),
          */
/*  DropDownFormField(
            titleText: 'Batch',
            hintText: 'Please choose one',
            value: batch,
            onSaved: (value) {
              setState(() {
                batch = value;
              });
            },
            onChanged: (value) {
              setState(() {
                batch = value;
              });
            },
            dataSource: [
              {
                "display": 2016,
                "value": 2016,
              },
              {
                "display": 2017,
                "value": 2017,
              },
              {
                "display": 2018,
                "value": 2018,
              },
              {
                "display": 2019,
                "value": 2019,
              },
              {
                "display": 2020,
                "value": 2020,
              }
            ],
            textField: 'display',
            valueField: 'value',
          ),
          */
/* DropDownFormField(
            titleText: 'Branch',
            hintText: 'Please choose one',
            value: branch,
            onSaved: (value) {
              setState(() {
                branch = value;
              });
            },
            onChanged: (value) {
              setState(() {
                branch = value;
              });
            },
            dataSource: [
              {
                "display": "IT",
                "value": "IT",
              },
              {
                "display": "ECE",
                "value": "ECE",
              },
              {
                "display": "IT-BI",
                "value": "IT-BI",
              },
            ],
            textField: 'display',
            valueField: 'value',
          ),
         /* DropDownFormField(
            titleText: 'Semester',
            hintText: 'Please choose one',
            value: semester,
            onSaved: (value) {
              setState(() {
                semester = value;
              });
            },
            onChanged: (value) {
              setState(() {
                semester = value;
              });
            },
            dataSource: [
              {
                "display": 1,
                "value": 1,
              },
              {
                "display": 2,
                "value": 2,
              },
              {
                "display": 3,
                "value": 3,
              },
              {
                "display": 4,
                "value": 4,
              },
              {
                "display": 5,
                "value": 5,
              },
              {
                "display": 6,
                "value": 6,
              },
              {
                "display": 7,
                "value": 7,
              },
              {
                "display": 8,
                "value": 8,
              },
            ],
            textField: 'display',
            valueField: 'value',
          ),
          */
          */
