import 'package:flutter/material.dart';

class NavItem extends StatelessWidget {
  NavItem(
      {this.iconData, this.title, this.onPressed, this.color, this.isSelected});
  final title;
  final iconData;
  final Function onPressed;
  final color;
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        color: isSelected ? Color.fromRGBO(128, 128, 128, 0.25) : Colors.white,
      ),
      child: ListTile(
        title: title,
        leading: iconData,
        onTap: onPressed,
      ),
    );
  }
}
