import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(238, 241, 242, 1),
      child: SpinKitWave(
        color: Colors.blue,
        size: 50,
      ),
    );
  }
}