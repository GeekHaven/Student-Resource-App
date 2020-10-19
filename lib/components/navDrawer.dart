import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share/share.dart';
import 'package:studentresourceapp/components/navdrawerItem.dart';
import 'package:studentresourceapp/models/user.dart';
import 'package:studentresourceapp/pages/about.dart';
import 'package:studentresourceapp/pages/admin.dart';
import 'package:studentresourceapp/pages/announcements.dart';
import 'package:studentresourceapp/pages/downloads.dart';
import 'package:studentresourceapp/pages/home.dart';
import 'package:studentresourceapp/pages/userdetailgetter.dart';
import 'package:studentresourceapp/utils/emailutil.dart';
import 'package:studentresourceapp/utils/sharedpreferencesutil.dart';
import 'package:studentresourceapp/utils/signinutil.dart';
import 'package:studentresourceapp/utils/contstants.dart';
import '../pages/home.dart';
import '../utils/contstants.dart';

List<Color> _colors = [Constants.DARK_SKYBLUE, Constants.SKYBLUE];
List<double> _stops = [0.0, 0.9];

class NavDrawer extends StatefulWidget {
  NavDrawer({@required this.userData, this.admin});

  final User userData;
  final bool admin;

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
  User userLoad;
  Future fetchUserDetailsFromSharedPref() async {
    var result = await SharedPreferencesUtil.getStringValue(
        Constants.USER_DETAIL_OBJECT);
    Map valueMap = json.decode(result);
    User user = User.fromJson(valueMap);
    setState(() {
      userLoad = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(children: <Widget>[
        ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(
                widget.userData.name ?? ' ',
                style: TextStyle(
                  fontFamily: 'RobotoMono',
                  fontSize: 24.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              accountEmail: Text(
                widget.userData.email ?? ' ',
                style: TextStyle(
                  fontFamily: 'RobotoMono',
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
              currentAccountPicture: CircleAvatar(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(200),
                  child: CachedNetworkImage(
                    imageUrl: widget.userData.imageUrl,
                    fadeInCurve: Curves.easeIn,
                    placeholder: (BuildContext context, String string) {
                      return Icon(
                        Icons.person,
                      );
                    },
                  ),
                ),
              ),
            ),
            NavItem(
              title: Text(
                "Home",
                style: TextStyle(
                  color:
                      (current == 1) ? Constants.DARK_SKYBLUE : Constants.STEEL,
                  fontWeight: FontWeight.normal,
                  fontSize: 17.0,
                  fontFamily: 'RobotoMono',
                ),
              ),
              iconData: ImageIcon(
                AssetImage("assets/grey icons/browser.png"),
                color:
                    (current == 1) ? Constants.DARK_SKYBLUE : Constants.STEEL,
                size: 22.0,
              ),
              onPressed: () {
                setState(() {
                  current = 1;
                });
                Navigator.pop(context);
                Navigator.popUntil(context, ModalRoute.withName('/'));
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => Home(),
                  ),
                );
              },
              isSelected: current == 1 ? true : false,
            ),
            NavItem(
              title: Text(
                "Downloads",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color:
                      (current == 2) ? Constants.DARK_SKYBLUE : Constants.STEEL,
                  fontSize: 17.0,
                  fontFamily: 'RobotoMono',
                ),
              ),
              iconData: ImageIcon(
                AssetImage("assets/grey icons/download-Recovered.png"),
                color:
                    (current == 2) ? Constants.DARK_SKYBLUE : Constants.STEEL,
                size: 22.0,
              ),
              onPressed: () {
                setState(() {
                  current = 2;
                });

                Navigator.pop(context);
                Navigator.popUntil(context, ModalRoute.withName('/'));
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (BuildContext context) => Downloads()),
                );
              },
              isSelected: current == 2 ? true : false,
            ),
            NavItem(
              title: Text(
                "Announcements",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color:
                      (current == 7) ? Constants.DARK_SKYBLUE : Constants.STEEL,
                  fontSize: 17.0,
                  fontFamily: 'RobotoMono',
                ),
              ),
              iconData: Icon(
                // AssetImage("assets/grey icons/help-Recovered.png"),
                FontAwesomeIcons.bullhorn,
                color:
                    (current == 7) ? Constants.DARK_SKYBLUE : Constants.STEEL,
                size: 22.0,
              ),
              onPressed: () {
                setState(() {
                  current = 7;
                });

                Navigator.pop(context);
                Navigator.popUntil(context, ModalRoute.withName('/'));
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (BuildContext context) => Announcement()),
                );
              },
              isSelected: current == 7 ? true : false,
            ),
            NavItem(
              title: Text(
                "Share",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color:
                      (current == 3) ? Constants.DARK_SKYBLUE : Constants.STEEL,
                  fontSize: 17.0,
                  fontFamily: 'RobotoMono',
                ),
              ),
              iconData: ImageIcon(
                AssetImage("assets/grey icons/share-Recovered.png"),
                color:
                    (current == 3) ? Constants.DARK_SKYBLUE : Constants.STEEL,
                size: 22.0,
              ),
              onPressed: () async {
                final msgAndLink = await getShareAppUrl();
                // print(msgAndLink);
                Share.share(msgAndLink[0] + " - " + msgAndLink[1],
                    subject:
                        'Checkout the new Sem Breaker App on your Smart Phone.');
              },
              isSelected: false,
            ),
            NavItem(
              title: Text(
                "Feedback",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color:
                      (current == 4) ? Constants.DARK_SKYBLUE : Constants.STEEL,
                  fontSize: 17.0,
                  fontFamily: 'RobotoMono',
                ),
              ),
              iconData: ImageIcon(
                AssetImage("assets/grey icons/feedback-Recovered.png"),
                color:
                    (current == 4) ? Constants.DARK_SKYBLUE : Constants.STEEL,
                size: 22.0,
              ),
              onPressed: () {
                Email email = Email(
                    emailaddress: "studentresourceapp@gmail.com",
                    subject: "Feedback/Suggestions regarding SemBreaker App",
                    body:
                        "My Feedback/Suggestions for the SemBreaker App are:");
                email.launchEmail();
              },
              isSelected: false,
            ),
            NavItem(
              title: Text(
                "About",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color:
                      (current == 5) ? Constants.DARK_SKYBLUE : Constants.STEEL,
                  fontSize: 17.0,
                  fontFamily: 'RobotoMono',
                ),
              ),
              iconData: ImageIcon(
                AssetImage("assets/grey icons/help-Recovered.png"),
                color:
                    (current == 5) ? Constants.DARK_SKYBLUE : Constants.STEEL,
                size: 22.0,
              ),
              onPressed: () {
                setState(() {
                  current = 5;
                });
                Navigator.pop(context);
                Navigator.popUntil(context, ModalRoute.withName('/'));
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => About(),
                ));
              },
              isSelected: current == 5 ? true : false,
            ),
            if (widget.admin)
              NavItem(
                title: Text(
                  "Admin Panel",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: (current == 6)
                        ? Constants.DARK_SKYBLUE
                        : Constants.STEEL,
                    fontSize: 17.0,
                    fontFamily: 'RobotoMono',
                  ),
                ),
                iconData: Icon(
                  Icons.developer_mode,
                  color:
                      (current == 6) ? Constants.DARK_SKYBLUE : Constants.STEEL,
                  size: 22.0,
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => Admin(
                        uid: widget.userData.uid,
                      ),
                    ),
                  );
                },
                isSelected: false,
              ),
            NavItem(
              title: Text(
                "Log Out",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color:
                      (current == 6) ? Constants.DARK_SKYBLUE : Constants.STEEL,
                  fontSize: 17.0,
                  fontFamily: 'RobotoMono',
                ),
              ),
              iconData: ImageIcon(
                AssetImage("assets/grey icons/logout.png"),
                color:
                    (current == 6) ? Constants.DARK_SKYBLUE : Constants.STEEL,
                size: 22.0,
              ),
              onPressed: () {
                buildSignOutDialog(context);
              },
              isSelected: false,
            )
          ],
        ),
        Positioned(
          top: 50,
          right: 0,
          child: FlatButton(
            child: ImageIcon(
              AssetImage("assets/grey icons/edit.png"),
              color: Colors.white,
              size: 18.0,
            ),
            onPressed: () {
              buildShowModalBottomShee(context);
            },
          ),
        ),
      ]),
    );
  }

  Future buildSignOutDialog(BuildContext context) {
    return showDialog(
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
  }

  void buildShowModalBottomShee(BuildContext context) {
    String name = "";
    Color col = Colors.white;
    _selectedBranch = widget.userData.branch;
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      context: context,
      builder: (builder) {
        return Container(
          height: MediaQuery.of(context).size.height - 150,
          decoration: BoxDecoration(
              color: Constants.WHITE,
              borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(24.0),
                  topRight: const Radius.circular(24.0))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 12),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: 6,
                      width: 64,
                      color: Colors.black45,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Edit Profile",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, bottom: 25.0, top: 0.0),
                      child: Divider(
                        height: 10.0,
                        color: Colors.blue,
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 3.0),
                        child: Text(
                          "Edit Name",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        initialValue: name,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: widget.userData.name,
                          labelText: 'Name',
                        ),
                        onChanged: (value) {
                          name = value;
                        },
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 3.0),
                        child: Text(
                          "Edit Branch",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FormField<String>(
                        builder: (FormFieldState<String> state) {
                          return InputDecorator(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0))),
                            isEmpty: _selectedBranch == widget.userData.branch,
                            child: DropdownButtonHideUnderline(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 12.0, right: 12.0),
                                child: DropdownButton<String>(
                                  value: _selectedBranch,
                                  isDense: true,
                                  dropdownColor: Colors.white,
                                  onChanged: (String newValue) {
                                    setState(() {
                                      _selectedBranch = newValue;
                                      state.didChange(newValue);
                                    });
                                  },
                                  items: _branches.map(
                                    (String value) {
                                      return DropdownMenuItem<String>(
                                        child: Text(value),
                                        value: value,
                                      );
                                    },
                                  ).toList(),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await Firestore.instance
                            .collection('userDetails')
                            .document(widget.userData.uid.toString())
                            .updateData({
                          'name': name == "" ? widget.userData.name : name,
                          'branch': _selectedBranch,
                        });
                        await fetchUserDetailsFromSharedPref();
                        userLoad.branch = _selectedBranch;
                        userLoad.name =
                            name == "" ? widget.userData.name : name;

                        await SharedPreferencesUtil.setBooleanValue(
                            Constants.USER_LOGGED_IN, true);
                        await SharedPreferencesUtil.setStringValue(
                            Constants.USER_DETAIL_OBJECT, userLoad);
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => Home()),
                          ModalRoute.withName("/Home"),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 36, bottom: 36, left: 108, right: 108),
                        child: Container(
                          height: 50.0,
                          width: 30.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            gradient: LinearGradient(
                              colors: _colors,
                              stops: _stops,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Center(
                              child: Text(
                                "Save",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, bottom: 25.0, top: 0.0),
                      child: Divider(
                        height: 10.0,
                        color: Colors.blue,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          "Unique User ID (Tap To Copy)",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(
                            () {
                              Clipboard.setData(
                                ClipboardData(text: widget.userData.uid),
                              );
                            },
                          );
                        },
                        child: DottedBorder(
                          radius: Radius.circular(12),
                          color: Constants.DARK_SKYBLUE,
                          padding: EdgeInsets.all(8),
                          strokeWidth: 1,
                          child: Center(
                            child: Container(
                              color: col,
                              child: SelectableText(
                                widget.userData.uid,
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

Future<List<String>> getShareAppUrl() async {
  QuerySnapshot snap =
      await Firestore.instance.collection("playstoreURL").getDocuments();
  return [snap.documents.first.data["msg"], snap.documents.first.data["link"]];
}
