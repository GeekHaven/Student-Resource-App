import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:studentresourceapp/components/navDrawer.dart';
import 'package:studentresourceapp/models/user.dart';
import 'package:studentresourceapp/pages/subject.dart';
import 'package:studentresourceapp/utils/contstants.dart';
import 'package:studentresourceapp/utils/sharedpreferencesutil.dart';

import 'package:studentresourceapp/utils/signinutil.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

//final _firestoreSemester = Firestore.instance.collection('Semesters');

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  User userLoad = new User();
  bool semesterExists = true;

  Future fetchUserDetailsFromSharedPref() async {
    var result = await SharedPreferencesUtil.getStringValue(
        Constants.USER_DETAIL_OBJECT);
    Map valueMap = json.decode(result);
    User user = User.fromJson(valueMap);
    setState(() {
      userLoad = user;
    });

    final snapShot = await Firestore.instance
        .collection('Semesters')
        .document('${user.semester.toString()}')
        .get();
    print('${user.semester.toString()} is the current semester');
    if (snapShot.exists) {
      print('Semester data exists');
      setState(() {
        semesterExists = true;
      });
    } else {
      print('Semester Data DNE');
      setState(() {
        semesterExists = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserDetailsFromSharedPref();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      drawer: NavDrawer(userData: userLoad),
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Container(
          child: semesterExists
              ? StreamBuilder(
                  stream: Firestore.instance
                      .collection('Semesters')
                      .document('${userLoad.semester}')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      Map branchSubjects = snapshot.data['branches']
                          ['${userLoad.branch.toUpperCase()}'];
                      print(branchSubjects.toString());
                      List<Widget> subjects = [];
                      branchSubjects.forEach((key, value) {
                        subjects.add(
                          Card(
                            child: ListTile(
                              title: Text(key),
                              subtitle: Text(value),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return Subject(
                                          semester: userLoad.semester,
                                          subjectCode: key);
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                        //print("key : $key, value : $value");
                      });
                      return Container(child: ListView(children: subjects));
                    }
                    return CircularProgressIndicator();
                  },
                )
              : Center(
    child: TyperAnimatedTextKit(        //Case when there is no Material present
    onTap: () {
    print("Tap Event");
    },
        speed: Duration(milliseconds: 100),   //Duration of TextAnimation

    text: [
    "Oops😵",
    "It feels Lonely Here🙄",
    "The Content is not Uploaded yet😬",
    "It's Still Under Construction🚧",
      "It would be Uploaded Soon😃"
    ],
    textStyle: TextStyle(
    fontSize: 25.0,
    fontFamily: "Agne"
    ),
    textAlign: TextAlign.center,
    alignment: AlignmentDirectional.topStart // or Alignment.topLeft
    ),
    ),
    )));
  }
}

/*
StreamBuilder(
        stream: Firestore.instance
            .collection('Semesters')
            .document(userLoad.semester.toString())
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          final semesterData = snapshot.data;
          print(semesterData['branches']);
          return Text(semesterData['branches'].toString());
        },
      )
 */
