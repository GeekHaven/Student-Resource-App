import 'package:flutter/material.dart';
import 'package:studentresourceapp/pages/home.dart';
import 'package:studentresourceapp/utils/signinutil.dart';

class SignIn extends StatelessWidget {
  final String college;
  final int batch;
  final String branch;
  final int semester;
  SignIn({this.college, this.batch, this.branch, this.semester});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlutterLogo(size: 50),
              FlatButton(
                  child: Chip(
                    label: Text('Sign-In with Google'),
                  ),
                  onPressed: () {
                    SignInUtil(
                            college: college,
                            semester: semester,
                            batch: batch,
                            branch: branch)
                        .signInWithGoogle()
                        .whenComplete(() {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return Home();
                          },
                        ),
                      );
                    });
                  })
            ],
          ),
        ),
      ),
    ));
  }
}
