import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/accordian/gf_accordian.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:studentresourceapp/components/navDrawer.dart';
import 'package:studentresourceapp/models/user.dart';
import 'package:studentresourceapp/utils/contstants.dart';
import 'package:studentresourceapp/utils/sharedpreferencesutil.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  User userLoad = new User();
  bool admin = false;
  Future fetchUserDetailsFromSharedPref() async {
    var result = await SharedPreferencesUtil.getStringValue(
        Constants.USER_DETAIL_OBJECT);
    Map valueMap = json.decode(result);
    User user = User.fromJson(valueMap);
    setState(() {
      userLoad = user;
    });
  }

  Future checkIfAdmin() async {
    final QuerySnapshot result =
        await Firestore.instance.collection('admins').getDocuments();
    final List<DocumentSnapshot> documents = result.documents;
    documents.forEach((data) {
      if (data.documentID == userLoad.uid) {
        setState(() {
          admin = true;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    fetchUserDetailsFromSharedPref();
    checkIfAdmin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(
        userData: userLoad,
        admin: admin,
      ),
      appBar: AppBar(title: Text('About Us')),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              GFAccordion(
                collapsedTitlebackgroundColor: Colors.transparent,
                expandedTitlebackgroundColor: Colors.transparent,
                contentbackgroundColor: Colors.transparent,
                collapsedIcon: Text(''),
                expandedIcon: Text(''),
                showAccordion: true,
                titlePadding: EdgeInsets.only(right: 10, left: 10, top: 10),
                titleChild: ListTile(
                  leading: Icon(
                    FontAwesomeIcons.featherAlt,
                    size: 32,
                    color: Constants.DARK_SKYBLUE,
                  ),
                  title: Text(
                    'About the App',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                ),
                contentPadding: EdgeInsets.only(left: 80),
                contentChild: Padding(
                  padding: const EdgeInsets.only(right: 14),
                  child: RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontFamily: 'Montserrat'),
                      children: [
                        TextSpan(
                          text:
                              'Hola Friends! We all know the importance of notes given out by the professors and our mighty toppers. Even when the \"Indian guy on YouTube\" fails to get things into our thick brains, it is these notes that come to our rescue. Now what if there was a central place where you would get all the magical notes and material to sail through these examinations, like a complete pro! Fret not, for we present to you, the ',
                        ),
                        TextSpan(
                            text: 'SemBreaker App',
                            style: TextStyle(fontWeight: FontWeight.w600)),
                        TextSpan(text: '. Sounds fun, right?'),
                      ],
                    ),
                  ),
                ),
              ),
              GFAccordion(
                collapsedTitlebackgroundColor: Colors.transparent,
                expandedTitlebackgroundColor: Colors.transparent,
                contentbackgroundColor: Colors.transparent,
                collapsedIcon: Text(''),
                expandedIcon: Text(''),
                titlePadding: EdgeInsets.only(
                  right: 10,
                  left: 10,
                ),
                titleChild: ListTile(
                  leading: Icon(
                    Icons.settings,
                    color: Constants.DARK_SKYBLUE,
                    size: 32,
                  ),
                  title: Text(
                    'Features',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                ),
                contentPadding: EdgeInsets.only(left: 80, right: 14),
                contentChild: Column(
                  children: <Widget>[
                    RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontFamily: 'Montserrat'),
                        children: [
                          TextSpan(
                            text: '\u2022 ',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          TextSpan(
                            text:
                                'One place access to all the important notes, study materials and previous year questions papers of the examinations.',
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontFamily: 'Montserrat'),
                        children: [
                          TextSpan(
                            text: '\u2022 ',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          TextSpan(
                            text:
                                'Get the material across various semesters & courses.',
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontFamily: 'Montserrat'),
                        children: [
                          TextSpan(
                            text: '\u2022 ',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          TextSpan(
                            text:
                                'Download the material that is important to you on your local phone storage.',
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontFamily: 'Montserrat'),
                        children: [
                          TextSpan(
                            text: '\u2022 ',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          TextSpan(
                            text:
                                'If you have got the notes you want upload, contact the moderator of the course mentioned in the app.',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              GFAccordion(
                collapsedTitlebackgroundColor: Colors.transparent,
                expandedTitlebackgroundColor: Colors.transparent,
                contentbackgroundColor: Colors.transparent,
                collapsedIcon: Text(''),
                expandedIcon: Text(''),
                titlePadding: EdgeInsets.only(
                  right: 10,
                  left: 10,
                ),
                titleChild: ListTile(
                  leading: Icon(
                    Icons.settings_ethernet,
                    color: Constants.DARK_SKYBLUE,
                    size: 32,
                  ),
                  title: Text(
                    'Contributors',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                ),
                contentPadding: EdgeInsets.only(left: 80),
                contentChild: Column(
                  children: <Widget>[
                    FlatButton(
                      padding: EdgeInsets.zero,
                      onPressed: () =>
                          launch('https://github.com/Cybertron-Avneesh'),
                      child: GFListTile(
                        padding: EdgeInsets.only(
                            right: 8, left: 0, bottom: 10, top: 10),
                        margin: EdgeInsets.all(0),
                        title: Text(
                          'Avneesh Kumar',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        avatar: GFAvatar(
                          backgroundColor: Constants.DARK_SKYBLUE,
                          size: GFSize.MEDIUM + 2,
                          child: GFAvatar(
                            backgroundImage: CachedNetworkImageProvider(
                                'https://avatars1.githubusercontent.com/u/54072374'),
                          ),
                        ),
                      ),
                    ),
                    FlatButton(
                      padding: EdgeInsets.zero,
                      onPressed: () =>
                          launch('https://github.com/singhalpranav22'),
                      child: GFListTile(
                        padding: EdgeInsets.only(
                            right: 8, left: 0, bottom: 10, top: 10),
                        margin: EdgeInsets.all(0),
                        title: Text(
                          'Pranav Singhal',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        avatar: GFAvatar(
                          backgroundColor: Constants.DARK_SKYBLUE,
                          size: GFSize.MEDIUM + 2,
                          child: GFAvatar(
                            backgroundImage: CachedNetworkImageProvider(
                                'https://avatars2.githubusercontent.com/u/51447798'),
                          ),
                        ),
                      ),
                    ),
                    FlatButton(
                      onPressed: () => launch('https://github.com/lazyp4nd4'),
                      padding: EdgeInsets.zero,
                      child: GFListTile(
                        padding: EdgeInsets.only(
                            right: 8, left: 0, bottom: 10, top: 10),
                        margin: EdgeInsets.all(0),
                        title: Text(
                          'Shourya',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        avatar: GFAvatar(
                          backgroundColor: Constants.DARK_SKYBLUE,
                          size: GFSize.MEDIUM + 2,
                          child: GFAvatar(
                            backgroundImage: CachedNetworkImageProvider(
                                'https://avatars3.githubusercontent.com/u/58784199'),
                          ),
                        ),
                      ),
                    ),
                    FlatButton(
                      padding: EdgeInsets.zero,
                      onPressed: () => launch('https://github.com/tktakshila'),
                      child: GFListTile(
                        padding: EdgeInsets.only(
                            right: 8, left: 0, bottom: 10, top: 10),
                        margin: EdgeInsets.all(0),
                        title: Text(
                          'Tushar Kumar',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        avatar: GFAvatar(
                          backgroundColor: Constants.DARK_SKYBLUE,
                          size: GFSize.MEDIUM + 2,
                          child: GFAvatar(
                            backgroundImage: CachedNetworkImageProvider(
                                'https://avatars0.githubusercontent.com/u/58617063'),
                          ),
                        ),
                      ),
                    ),
                    FlatButton(
                      padding: EdgeInsets.zero,
                      onPressed: () =>
                          launch('https://github.com/yuktagopalani'),
                      child: GFListTile(
                        padding: EdgeInsets.only(
                            right: 8, left: 0, bottom: 10, top: 10),
                        margin: EdgeInsets.all(0),
                        title: Text(
                          'Yukta Gopalani',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        avatar: GFAvatar(
                          backgroundColor: Constants.DARK_SKYBLUE,
                          size: GFSize.MEDIUM + 2,
                          child: GFAvatar(
                            backgroundImage: CachedNetworkImageProvider(
                                'https://avatars2.githubusercontent.com/u/59793009'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GFAccordion(
                collapsedTitlebackgroundColor: Colors.transparent,
                expandedTitlebackgroundColor: Colors.transparent,
                contentbackgroundColor: Colors.transparent,
                collapsedIcon: Text(''),
                expandedIcon: Text(''),
                titlePadding: EdgeInsets.only(
                  right: 10,
                  left: 10,
                ),
                titleChild: ListTile(
                  leading: ImageIcon(
                    AssetImage('assets/images/geekhaven.png'),
                    color: Constants.DARK_SKYBLUE,
                    size: 32,
                  ),
                  title: Text(
                    'About GeekHaven',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                ),
                contentPadding: EdgeInsets.only(left: 80),
                contentChild: Padding(
                  padding: const EdgeInsets.only(right: 14),
                  child: Text(
                    'GeekHaven is the technical Society of IIIT Allahabad. Geekhaven is comprised of several wings. Comprising of some of the best technical minds of the college, GeekHaven is responsible for organising technical events throughout the year and promoting an overall technical culture in the college by holding regular workshops and quick-talks. For any queries shoot us a mail at geekhaven@iiita.ac.in or contact us via the social media links.',
                    style: TextStyle(fontSize: 14),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
