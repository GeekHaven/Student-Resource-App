import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class NoContentAnimatedText extends StatelessWidget {
  const NoContentAnimatedText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TyperAnimatedTextKit(
          //Case when there is no Material present
          onTap: () {
            print("Tap Event");
          },
          speed: Duration(
              milliseconds: 100), //Duration of TextAnimation

          text: [
            "Oops😵",
            "It feels Lonely Here🙄",
            "Subjects are not Added yet😬",
          ],
          textStyle: TextStyle(
            fontSize: 25.0,
          ),
          textAlign: TextAlign.center,
          alignment: AlignmentDirectional
              .topStart // or Alignment.topLeft
          ),
    );
  }
}