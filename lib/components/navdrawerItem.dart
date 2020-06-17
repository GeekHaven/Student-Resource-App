import 'package:flutter/material.dart';

class NavItem extends StatelessWidget {
  const NavItem({
  this.iconData, this.title, this.onPressed
  });
  final String title;
  final IconData iconData;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(title: Text(title),
        leading: Icon(iconData), onTap: onPressed);

  }
}