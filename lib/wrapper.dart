import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentresourceapp/authentication/authentication.dart';
import 'package:studentresourceapp/home/home.dart';
import 'package:studentresourceapp/model/user.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);

    if(user == null)
    {
      return Authenticate();
    }
    else{
      return Home();
    }

  }
}