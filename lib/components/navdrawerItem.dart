import 'package:flutter/material.dart';

class NavItem extends StatelessWidget {
  const NavItem({
  this.iconData, this.title, this.onPressed,this.color
  });
  final  title;
  final iconData;
  final Function onPressed;
  final color;

  @override
  Widget build(BuildContext context) {
    return ListTile(title:title , leading: iconData, onTap: onPressed,);
  }
}