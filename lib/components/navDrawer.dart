import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:studentresourceapp/components/navdrawerItem.dart';
import 'package:studentresourceapp/models/user.dart';
import 'package:studentresourceapp/pages/about.dart';
import 'package:studentresourceapp/pages/home.dart';
import 'package:studentresourceapp/pages/userdetailgetter.dart';
import 'package:studentresourceapp/utils/contstants.dart';
import 'package:studentresourceapp/utils/sharedpreferencesutil.dart';
import 'package:studentresourceapp/utils/signinutil.dart';

class NavDrawer extends StatefulWidget {
  NavDrawer({
    @required this.userData,
  });

  final User userData;

  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  String name;
  String email;
  String uid;
  String college;
  int batch;
  String imageUrl;
  List<String> _branches = ['IT', 'ITBI', 'ECE'];

  String _selectedBranch;

  List<int> _semester = [1, 2, 3, 4, 5, 6, 7, 8];

  int _selectedSemester;

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Stack(children: <Widget>[
      ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(widget.userData.name ?? ' '),
            accountEmail: Text(widget.userData.email ?? ' '),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Theme.of(context).platform == TargetPlatform.iOS
                  ? Colors.blue
                  : Colors.white,
              child: Image(image: NetworkImage(widget.userData.imageUrl ?? '')),
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
                            Navigator.popUntil(
                                context, ModalRoute.withName('/'));
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
                            Navigator.popUntil(
                                context, ModalRoute.withName('/'));
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
      ),
      Positioned(
        top: 30,
        right: 0,
        child: FlatButton(
            child: Icon(
              Icons.edit,
              color: Colors.white,
            ),

            color: Colors.blue,
        NavItem(
            title: 'Feedback',
            iconData: Icons.feedback,
            onPressed: () {

              Email email=Email(emailaddress: "studentresourceapp@gmail.com",subject: "Feedback/Suggestions regarding SemBreaker App",body:"My Feedback/Suggestions for the SemBreaker App are:" );
              email.launchEmail();
            
            }),
        NavItem(
            title: 'About',
            iconData: Icons.info,
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: <Widget>[
                          TextField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Name',
                                hintText: widget.userData.name),
                            onChanged: (value) {
                              setState(() {
                                name = value;
                              });
                            },
                          ),
                          Text('Semester'),
                          FormField<int>(
                            builder: (FormFieldState<int> state) {
                              return InputDecorator(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0))),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<int>(
                                    value: _selectedSemester,
                                    isDense: true,
                                    onChanged: (int newValue) {
                                      setState(() {
                                        _selectedSemester = newValue;
                                        state.didChange(newValue);
                                      });
                                    },
                                    items: _semester.map((int value) {
                                      return DropdownMenuItem<int>(
                                        value: value,
                                        child: Text(value.toString()),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              );
                            },
                          ),
                          Text('Branch'),
                          FormField<String>(
                            builder: (FormFieldState<String> state) {
                              return InputDecorator(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0))),
                                isEmpty: _selectedBranch == '',
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: _selectedBranch,
                                    isDense: true,
                                    onChanged: (String newValue) {
                                      setState(() {
                                        _selectedBranch = newValue;
                                        state.didChange(newValue);
                                      });
                                    },
                                    items: _branches.map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 10),
                          RaisedButton(
                            onPressed: () {
                              setState(() async {
                                Firestore.instance
                                    .collection('userDetails')
                                    .document(widget.userData.uid.toString())
                                    .updateData({
                                  'name': name,
                                  'branch': _selectedBranch,
                                  'semester': _selectedSemester,
                                });
                                Navigator.pop(context);
                              });
                            },
                            child: Text('Save Changes'),
                          )
                        ],
                      ),
                    );
                  });
            }),
      ),
    ]));
  }
}

