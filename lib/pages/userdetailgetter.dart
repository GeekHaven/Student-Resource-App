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

  List<String> _college = ['IIITA', 'Others'];
  String _selectedCollege;

  List<String> _branches = ['IT', 'ITBI', 'ECE'];
  String _selectedBranch;

  List<int> _semester = [1, 2, 3, 4, 5, 6, 7, 8];
  int _selectedSemester;

  List<int> _batches = [2020, 2019, 2018, 2017, 2016];
  int _selectedBatch;

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
            child: Center(
              child: Container(
                color: Colors.grey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
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
                    child: DropdownButton(
                      hint: Text('Please choose a college'),
                      value: _selectedCollege,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedCollege = newValue;
                        });
                      },
                      items: _college.map((college) {
                        return DropdownMenuItem(
                          child: new Text(college),
                          value: college,
                        );
                      }).toList(),
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
                    child: DropdownButton(
                      hint: Text('Please choose your batch'),
                      value: _selectedBatch,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedBatch = newValue;
                        });
                      },
                      items: _batches.map((batch) {
                        return DropdownMenuItem(
                          child: new Text(batch.toString()),
                          value: batch,
                        );
                      }).toList(),
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
                    child: DropdownButton(
                      hint: Text(
                          'Please choose your branch'),
                      value: _selectedBranch,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedBranch = newValue;
                        });
                      },
                      items: _branches.map((branch) {
                        return DropdownMenuItem(
                          child: new Text(branch),
                          value: branch,
                        );
                      }).toList(),
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
                    child: DropdownButton(
              hint: Text('Please choose your current semester'),
              value: _selectedSemester,
              onChanged: (newValue) {
                setState(() {
                  _selectedSemester = newValue;
                });
              },
              items: _semester.map((semester) {
                return DropdownMenuItem(
                  child: new Text(semester.toString()),
                  value: semester,
                );
              }).toList(),
          ),
                  ),
                  RaisedButton(
                      child: Text('Proceed'),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return SignIn(
                                  college: _selectedCollege,
                                  batch: _selectedBatch,
                                  branch: _selectedBranch,
                                  semester: _selectedSemester);
                            },
                          ),
                        );
                      })
                ]),
              ),
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
