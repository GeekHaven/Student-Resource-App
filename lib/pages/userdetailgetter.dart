import 'package:flutter/material.dart';
import 'package:studentresourceapp/pages/signin.dart';

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
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                        hint: Text('Please choose your branch'),
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
    );
  }
}
