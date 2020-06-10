import 'package:flutter/material.dart';
import 'package:studentresourceapp/authentication/login.dart';
import 'package:studentresourceapp/authentication/register.dart';


class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {


  bool showRegister = true;

  void changeAuthView() {
    setState(() => showRegister = !showRegister); 
  }

  @override
  Widget build(BuildContext context) {
    if(showRegister == true){
      return SignUp(changeAuthView: changeAuthView);
    } else {
      return SignIn(changeAuthView: changeAuthView);
    }
  }
}