import 'package:flutter/material.dart';

int current = 1;

class Constants {
  static const USER_LOGGED_IN = 'is_user_logged_in';
  static const USER_DETAIL_OBJECT = 'user_object';
  static const COLLECTION_NAME_USER = 'userDetails';

  /* Colors */
  static const Color SMOKE = Color(0xffAFAFAF); // Tile separator color
  static const Color MERCURY = Color(0xffE5E5E5); // Screen BackGround Color
  static const Color STEEL = Color(0xff7A7A7A); // SubjectFull Name Color
  static const Color SKYBLUE = Color(0xff79DBE8); // gradient end color
  static const Color DARK_SKYBLUE = Color(0xff00BCD4); // theme color
  static const Color BLACK = Color(0xff000000); // subjectcode color
  static const Color WHITE = Color(0xffFFFFFF);

  static const kTextFieldDecoration = InputDecoration(
    filled: true,
    fillColor: Colors.white,
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xffD9A2EF), width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xffB600FF), width: 2.0),
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ),
  );
}
