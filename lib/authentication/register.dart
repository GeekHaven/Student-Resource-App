import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:studentresourceapp/service/auth.dart';
import 'package:flutter/material.dart';
import 'package:studentresourceapp/shared/loading.dart';

class SignUp extends StatefulWidget {
  final Function changeAuthView;
  SignUp({this.changeAuthView});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final AuthService _auth = AuthService();
  bool loading = false;
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String name = '';
  String branch = '';
  String batch = '';
  String semester = '';
  String college = '';

  @override
  Widget build(BuildContext context) {
    return loading == true ? Loading() : Scaffold(
      backgroundColor: Color.fromRGBO(238, 241, 242, 1),
      appBar: AppBar(
          backgroundColor: Color.fromRGBO(238, 241, 242, 1),
          elevation: 0,
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Sign In',
                style: TextStyle(color: Colors.black45),
              ),
              onPressed: () {
                widget.changeAuthView();
              },
            ),
          ],
          title: Text(
            'Register',
            style: TextStyle(
              color: Colors.black,
            ),
          )),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextFormField(
                      validator: (val) => val.isEmpty ? 'Enter an email' : null,
                      onChanged: (val) => setState(() => email = val),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Email',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextFormField(
                      obscureText: true,
                      validator: (val) => val.length < 6 ? 'Minimum length of Password should be 6 characters' : null,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextFormField(
                      validator: (val) => val.isEmpty ? 'Enter your Name' : null,
                      onChanged: (val) => setState(() => name = val),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Name',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: DropDownFormField(
                      validator: (value) => value == '' ? 'Please select your year of admission' : null,
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
                          "display": '2020',
                          "value": '2020',
                        },
                        {
                          "display": '2019',
                          "value": '2019',
                        },
                        {
                          "display": '2018',
                          "value": '2018',
                        },
                        {
                          "display": '2017',
                          "value": '2017',
                        },
                        {
                          "display": '2016',
                          "value": '2016',
                        },
                      ],
                      textField: 'display',
                      valueField: 'value',
                    ),
                  ),
                  
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: DropDownFormField(
                      validator: (value) => value.isEmpty ? 'Please select your current semester' : null,
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
                          "display": '1',
                          "value": '1',
                        },
                        {
                          "display": '2',
                          "value": '2',
                        },
                        {
                          "display": '3',
                          "value": '3',
                        },
                        {
                          "display": '4',
                          "value": '4',
                        },
                        {
                          "display": '5',
                          "value": '5',
                        },
                        {
                          "display": '6',
                          "value": '6',
                        },
                        {
                          "display": '7',
                          "value": '7',
                        },
                        {
                          "display": '8',
                          "value": '8',
                        },
                      ],
                      textField: 'display',
                      valueField: 'value',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: DropDownFormField(
                      validator: (value) => value.isEmpty ? 'Please select a branch' : null,
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
                          "display": "IT-BI",
                          "value": "IT-BI",
                        },
                        {
                          "display": "ECE",
                          "value": "ECE",
                        },
                      ],
                      textField: 'display',
                      valueField: 'value',
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: DropDownFormField(
                      validator: (value) => value.isEmpty ? 'Please select your college' : null,
                      titleText: 'College',
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
                          "display": "IIIT Allahabad",
                          "value": "IIIT Allhabad",
                        },
                        {
                          "display": "Others",
                          "value": "Others",
                        },
                      ],
                      textField: 'display',
                      valueField: 'value',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  MaterialButton(
                    minWidth: double.infinity,
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        setState(() {
                          loading = true;
                        });
                        dynamic result = _auth.register(
                            email, password, name, branch, batch, college, semester);
                        if (result == null) {
                          setState(() {
                            loading = false;
                          });
                          Fluttertoast.showToast(
                              msg: 'Error', toastLength: Toast.LENGTH_SHORT);
                        }
                      }
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 0,
                    color: Colors.blue,
                    padding: EdgeInsets.all(15),
                    child: Text(
                      'Register',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
