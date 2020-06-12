import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:studentresourceapp/models/user.dart';
import 'package:studentresourceapp/utils/contstants.dart';
import 'package:studentresourceapp/utils/sharedpreferencesutil.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
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
    return Scaffold(
      appBar: AppBar(title: Text('About')),
    );
  }
}
