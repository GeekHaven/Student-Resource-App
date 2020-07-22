import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FlareActor(
        'assets/flareFiles/book_loader.flr',
        alignment: Alignment.center,
        animation: 'opening_closing',
      ),
    );
  }
}
