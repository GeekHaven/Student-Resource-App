import 'dart:convert';
import 'package:circle_list/circle_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:studentresourceapp/components/custom_loader.dart';
import 'package:studentresourceapp/components/navDrawer.dart';
import 'package:studentresourceapp/models/user.dart';
import 'package:studentresourceapp/pages/subject.dart';
import 'package:studentresourceapp/utils/contstants.dart';
import 'package:studentresourceapp/utils/sharedpreferencesutil.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../utils/contstants.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  User userLoad = new User();
  bool semesterExists = true;
  ScrollController _scrollController;
  AnimationController _hideFabAnimController;

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

    _scrollController = ScrollController();
    _hideFabAnimController = AnimationController(
      vsync: this,
      duration: kThemeAnimationDuration,
      value: 1, // initially visible
    );
    _scrollController.addListener(() {
      switch (_scrollController.position.userScrollDirection) {
        // Scrolling up - forward the animation (value goes to 1)
        case ScrollDirection.forward:
          _hideFabAnimController.forward();
          break;
        // Scrolling down - reverse the animation (value goes to 0)
        case ScrollDirection.reverse:
          _hideFabAnimController.reverse();
          break;
        // Idle - keep FAB visibility unchanged
        case ScrollDirection.idle:
          break;
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _hideFabAnimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(userData: userLoad),
      appBar: AppBar(
        backgroundColor: Constants.DARK_SKYBLUE,
        elevation: 0,
        bottom: PreferredSize(
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 12,
                left: 16,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Semester ${userLoad.semester ?? ''}",
                    style: TextStyle(
                        fontSize: 24,
                        color: Constants.WHITE,
                        fontWeight: FontWeight.w600)),
              ),
            ),
            preferredSize: Size.fromHeight(28)),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: semesterExists
            ? StreamBuilder(
                stream: Firestore.instance
                    .collection('Semesters')
                    .document('${userLoad.semester}')
                    .snapshots(),
                builder: (context, snapshot) {
                  try {
                    if (snapshot.hasData) {
                      Map branchSubjects = snapshot.data['branches']
                          ['${userLoad.branch.toUpperCase()}'];
                      print(branchSubjects.toString());
                      List<Widget> subjects = [];
                      branchSubjects.forEach((key, value) {
                        subjects.add(
                          FlatButton(
                            child: ListTile(
                              leading: Image.asset(
                                'assets/images/Computer.png',
                                height: 32,
                              ),
                              title: Text(
                                key,
                                style: TextStyle(
                                    color: Constants.BLACK,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                              subtitle: Text(
                                value,
                                style: TextStyle(
                                    color: Constants.STEEL,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                              trailing: Icon(
                                Icons.keyboard_arrow_right,
                                color: Constants.BLACK,
                                size: 36,
                              ),
                            ),
                            splashColor: Constants.SKYBLUE,
                            onPressed: () {
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
                        );
                      });
                      subjects.add(SizedBox(
                        height: 100,
                      ));

                      return Container(
                          child: ListView.separated(
                        controller: _scrollController,
                        itemCount: subjects.length,
                        separatorBuilder: (BuildContext context, int index) =>
                            Divider(
                          thickness: 0.5,
                          color: Constants.SMOKE,
                          indent: 24,
                          endIndent: 24,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return subjects[index];
                        },
                      ));
                    }
                  } catch (err) {
                    return Center(
                        child: Text(
                            'No Content available for this semester.\n Come back later'));
                  }
                  return CustomLoader();
                },
              )
            : Center(
                child: TyperAnimatedTextKit(
                    //Case when there is no Material present
                    onTap: () {
                      print("Tap Event");
                    },
                    speed:
                        Duration(milliseconds: 100), //Duration of TextAnimation

                    text: [
                      "Oops😵",
                      "It feels Lonely Here🙄",
                      "The Content is not Uploaded yet😬",
                      "It's Still Under Construction🚧",
                      "It would be Uploaded Soon😃"
                    ],
                    textStyle: TextStyle(fontSize: 25.0, fontFamily: "Agne"),
                    textAlign: TextAlign.center,
                    alignment:
                        AlignmentDirectional.topStart // or Alignment.topLeft
                    ),
              ),
      ),
      floatingActionButton: FadeTransition(
        opacity: _hideFabAnimController,
        child: ScaleTransition(
          scale: _hideFabAnimController,
          child: FloatingActionButton.extended(
              backgroundColor: Constants.DARK_SKYBLUE,
              elevation: 1,
              isExtended: true,
              label: Text(
                'Switch Sem',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      print(userLoad.semester);
                      return CircleList(
                        showInitialAnimation: true,
                        animationSetting: AnimationSetting(
                            duration: Duration(milliseconds: 800),
                            curve: Curves.fastOutSlowIn),
                        children: List.generate(
                          8,
                          (index) => ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(1000)),
                            child: MaterialButton(
                              height: 60,
                              minWidth: 60,
                              color: (index + 1) == userLoad.semester
                                  ? Constants.DARK_SKYBLUE
                                  : Constants.WHITE,
                              child: Text(
                                '${index + 1}',
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 36,
                                    color: Constants.BLACK,
                                    fontWeight: FontWeight.w600),
                              ),
                              onPressed: () async {
                                Navigator.of(context).pop();
                                setState(() {
                                  userLoad.semester = index + 1;
                                  SharedPreferencesUtil.setStringValue(
                                      Constants.USER_DETAIL_OBJECT, userLoad);
                                  Firestore.instance
                                      .collection(
                                          Constants.COLLECTION_NAME_USER)
                                      .document(userLoad.uid)
                                      .setData({'semester': index + 1},
                                          merge: true);
                                });
                              },
                            ),
                          ),
                        ),
                        outerCircleColor: Constants.WHITE,
                      );
                    });
              }),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
