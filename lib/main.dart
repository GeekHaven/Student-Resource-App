import 'package:flutter/material.dart';
import 'package:studentresourceapp/pages/blank.dart';
import 'package:studentresourceapp/pages/home.dart';
import 'package:studentresourceapp/pages/userdetailgetter.dart';
import 'package:studentresourceapp/utils/contstants.dart';
import 'package:studentresourceapp/utils/sharedpreferencesutil.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'SemBreaker',
        home: FutureBuilder(
          future:
              SharedPreferencesUtil.getBooleanValue(Constants.USER_LOGGED_IN),
          builder: (context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData) {
              return snapshot.data ? Home() : UserDetailGetter();
            }
            return Blank();
          },
        ));
  }
}
