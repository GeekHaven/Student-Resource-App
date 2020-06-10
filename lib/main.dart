import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentresourceapp/model/user.dart';
import 'package:studentresourceapp/service/auth.dart';
import 'package:studentresourceapp/wrapper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(home: Wrapper(),),
    );
  }
}
