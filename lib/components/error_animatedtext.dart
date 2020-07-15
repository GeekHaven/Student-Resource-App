import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class ErrorAnimatedText extends StatelessWidget {
  const ErrorAnimatedText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TyperAnimatedTextKit(
          //Case when there is no Material present
          onTap: () {
            //print("Tap Event");
          },
          speed:
              Duration(milliseconds: 100), //Duration of TextAnimation

          text: [
            "Oops😵, Something went wrong",
            "Try checking your Internet Connection😃"
          ],
          textStyle: TextStyle(
            fontSize: 25.0,
          ),
          textAlign: TextAlign.center,
          alignment:
              AlignmentDirectional.topStart // or Alignment.topLeft
          ),
    );
  }
}