import 'package:flutter/material.dart';

import '../main.dart';
import '../utils/signinutil.dart';
import 'userdetailgetter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final SignInUtil signInUtil = SignInUtil();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
      appBar: AppBar(title: Text('Home'),
        actions: <Widget>[
          FlatButton(child: Text('Sign Out'),
            onPressed: () {
              signInUtil.signOutGoogle();
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyApp()));
            },
          )
        ],
      ),  
      ),
    );
  }
}