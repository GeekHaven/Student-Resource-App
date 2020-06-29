import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studentresourceapp/pages/home.dart';
import 'package:studentresourceapp/utils/signinutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
              Image(image: AssetImage("assets/images/Logo.png"),
                height:200.0 ,
              ),

              SizedBox(height: 50),
                OutlineButton(
                    splashColor: Colors.grey,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                    highlightElevation: 0,
                    borderSide: BorderSide(color: Colors.grey),

                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Hero
                            (
                              tag: 'logo',
                              child: Image(image: AssetImage("assets/images/google_logo.png"), height: 35.0)),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              'Sign in with Google',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.grey,
                              ),
                            ),
                          )
                        ],
                      ),
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
