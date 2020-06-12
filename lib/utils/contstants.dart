import 'package:flutter/material.dart';

class Constants {
  static const USER_LOGGED_IN = 'is_user_logged_in';
  static const USER_DETAIL_OBJECT = 'user_object';
  static const COLLECTION_NAME_USER = 'userDetails';
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