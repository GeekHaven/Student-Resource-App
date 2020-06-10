import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:studentresourceapp/service/auth.dart';
import 'package:studentresourceapp/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function changeAuthView;
  SignIn({this.changeAuthView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool loading = false;
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return loading == true ? Loading() : Scaffold(
      backgroundColor: Color.fromRGBO(238, 241, 242, 1),
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Color.fromRGBO(238, 241, 242, 1),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Register',
                style: TextStyle(color: Colors.black45),
              ),
              onPressed: () {
                widget.changeAuthView();
              },
            ),
          ],
          title: Text(
            'Sign In',
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
              child: Column(children: <Widget>[
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
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    validator: (val) => val.length < 6
                        ? 'Password should contain minimum 6 characters'
                        : null,
                    onChanged: (val) {
                      setState(() => password = val);
                    },
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
                      dynamic result = await _auth.signIn(email, password);
                      if (result == null) {
                        setState(() {
                          loading = false;
                        });
                        Fluttertoast.showToast(
                            msg: 'Credentials Do Not Match',
                            toastLength: Toast.LENGTH_SHORT);
                      }
                    }
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 0,
                  color: Colors.blue,
                  padding: EdgeInsets.all(15),
                  child: Text(
                    'Sign In!',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
