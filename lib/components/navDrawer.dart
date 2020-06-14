import 'package:flutter/material.dart';
import 'package:studentresourceapp/components/navdrawerItem.dart';
import 'package:studentresourceapp/models/user.dart';
import 'package:studentresourceapp/pages/about.dart';
import 'package:studentresourceapp/pages/home.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({
    @required this.userData,
  });

  final User userData;

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: Text(userData.name ?? ' '),
          accountEmail: Text(userData.email ?? ' '),
          currentAccountPicture: CircleAvatar(
            backgroundColor: Theme.of(context).platform == TargetPlatform.iOS
                ? Colors.blue
                : Colors.white,
            child: Image(image: NetworkImage(userData.imageUrl ?? '')),
          ),
        ),
        NavItem(
            title: 'Home',
            iconData: Icons.home,
            onPressed: () {
              Navigator.pop(context);
              Navigator.popUntil(context, ModalRoute.withName('/'));
              Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext context) => Home()),
              );
            }),
        NavItem(
            title: 'Downloads',
            iconData: Icons.file_download,
            onPressed: () {
              Navigator.pop(context);
              Navigator.popUntil(context, ModalRoute.withName('/'));
              Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext context) => Home()),
              );
            }),
        NavItem(
            title: 'Share',
            iconData: Icons.share,
            onPressed: () {
              Navigator.pop(context);
              Navigator.popUntil(context, ModalRoute.withName('/'));
              Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext context) => Home()),
              );
            }),
        NavItem(
            title: 'About',
            iconData: Icons.info,
            onPressed: () {
              Navigator.pop(context);
              Navigator.popUntil(context, ModalRoute.withName('/'));
              Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => About(),
              ));
            })
      ],
    ));
  }
}
