import 'package:flutter/material.dart';
import 'package:studentresourceapp/components/navdrawerItem.dart';
import 'package:studentresourceapp/models/user.dart';
import 'package:studentresourceapp/pages/about.dart';
import 'package:studentresourceapp/pages/home.dart';
import 'package:studentresourceapp/pages/userdetailgetter.dart';
import 'package:studentresourceapp/utils/signinutil.dart';
import 'package:studentresourceapp/utils/emailutil.dart';

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
            title: 'Feedback',
            iconData: Icons.feedback,
            onPressed: () {
//              Navigator.pop(context);
//              Navigator.popUntil(context, ModalRoute.withName('/'));
//              Navigator.of(context).push(
//                MaterialPageRoute(builder: (BuildContext context) => Home()),
//              );
            Email email=Email();
            email.launchEmail("studentresourceapp@gmail.com");
            
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
            }),
      
        NavItem(
          title: 'Sign Out',
          iconData: Icons.all_out,
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Log Out'),
                    content: Text('Are you sure you want to log out?'),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.popUntil(context, ModalRoute.withName('/'));
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (BuildContext context) => Home()),
                          );
                        },
                        child: Text('No'),
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.popUntil(context, ModalRoute.withName('/'));
                          SignInUtil().signOutGoogle();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => UserDetailGetter()));
                        },
                        child: Text('Yes'),
                      ),
                    ],
                  );
                });
          },
        )
      ],
    ));
  }
}
