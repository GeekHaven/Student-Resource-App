import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:studentresourceapp/components/navDrawer.dart';
import 'package:studentresourceapp/models/user.dart';
import 'package:studentresourceapp/pages/userdetailgetter.dart';
import 'package:studentresourceapp/utils/contstants.dart';
import 'package:studentresourceapp/utils/sharedpreferencesutil.dart';
import 'package:studentresourceapp/utils/signinutil.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  User userLoad = new User();

  Future fetchUserDetailsFromSharedPref() async {
    var result = await SharedPreferencesUtil.getStringValue(Constants.USER_DETAIL_OBJECT);
    Map valueMap = json.decode(result);
    User user = User.fromJson(valueMap);
    setState(() {
      userLoad = user;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchUserDetailsFromSharedPref();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          drawer: NavDrawer(userData: userLoad),
          appBar: AppBar(
            title: Text('Home'),
            actions: <Widget>[
              FlatButton(
                child: Text('Sign Out'),
                onPressed: () {
                  SignInUtil().signOutGoogle();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => UserDetailGetter()));
                },
              )
            ],
          ),
          body: Container(child: Text(userLoad.name.toString()))),
    );
  }
}
