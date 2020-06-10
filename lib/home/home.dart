import 'package:flutter/material.dart';
import 'package:studentresourceapp/service/auth.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(238, 241, 242, 1),
      appBar: AppBar(
        actions: <Widget>[
          FlatButton(textColor: Colors.black45, child: Text('Sign Out'),onPressed: () async { await _auth.signOut();},)
        ],
          elevation: 0,
          backgroundColor: Color.fromRGBO(238, 241, 242, 1),
          title: Text(
            'Home',
            style: TextStyle(
              color: Colors.black,
            ),
          )),
    );
  }
}