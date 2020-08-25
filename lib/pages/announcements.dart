import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studentresourceapp/components/announcement_card.dart';
import 'package:intl/intl.dart';
import 'package:studentresourceapp/utils/sharedpreferencesutil.dart';
import 'package:studentresourceapp/models/user.dart';
import 'package:studentresourceapp/utils/contstants.dart';
import 'dart:convert';
import 'package:studentresourceapp/components/navDrawer.dart';

final _firestore = Firestore.instance;

class Announcement extends StatefulWidget {
  @override
  _AnnouncementState createState() => _AnnouncementState();
}

class _AnnouncementState extends State<Announcement> {
  bool admin = false;
  User userLoad = new User();
  String directory;
  List file = new List();
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

  List<dynamic> updatesList = [];
  @override
  void initState() {
    fetchUserDetailsFromSharedPref();
    checkIfAdmin();
    fetchUpdates();
  }

  void fetchUpdates() async {
    await for (var snapshot in _firestore
        .collection('announcements')
        .orderBy('createdAt', descending: true)
        .snapshots()) {
      List<dynamic> newUpdatesList = [];
      for (var message in snapshot.documents) {
        String title, messg, url, displayDate;
        messg = message.data['message'] ?? 'Message Text Unavailable';
        title = message.data['title'] ?? 'Event Unavailable';
        url = message.data['url'] ?? null;
        final timestamp = message.data['createdAt'] ?? 1580187210337;
        var date = new DateTime.fromMillisecondsSinceEpoch(timestamp);
        displayDate = DateFormat("dd MMM yyyy hh:mm a").format(date).toString();

        newUpdatesList.add(AnnounceCard(
          title: title,
          date: displayDate,
          message: messg,
          url: url,
        ));
      }
      newUpdatesList.add(SizedBox(
                    height: 100,
                  ));
      setState(() {
        updatesList = newUpdatesList;
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(
        userData: userLoad,
        admin: admin,
      ),
      appBar: AppBar(
        title: Text('Announcements'),
      ),
      body: Container(
        child: updatesList.length == 0
            ? Center(
                child: Text('No Announcements Yet!'),
              )
            : Container(
                child: ListView.builder(
                  itemCount: updatesList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return updatesList[index];
                  },
                ),
              ),
      ),
    );
  }
}
