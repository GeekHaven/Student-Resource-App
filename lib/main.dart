import 'package:flutter/material.dart';
import 'package:studentresourceapp/pages/blank.dart';
import 'package:studentresourceapp/pages/home.dart';
import 'package:studentresourceapp/pages/userdetailgetter.dart';
import 'package:studentresourceapp/utils/contstants.dart';
import 'package:studentresourceapp/utils/sharedpreferencesutil.dart';
import 'package:studentresourceapp/pages/subject.dart';

void main() {
  set();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      theme: ThemeData(
        highlightColor: Constants.DARK_SKYBLUE,
      ),
        title: 'SemBreaker',
        debugShowCheckedModeBanner: false,

        home: FutureBuilder(


          future:
              SharedPreferencesUtil.getBooleanValue(Constants.USER_LOGGED_IN),
          builder: (context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData) {
              return snapshot.data ? Home() : UserDetailGetter();
            }
            else
            return Blank();
          },
        ));
  }
}
