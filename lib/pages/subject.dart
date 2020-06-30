import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:studentresourceapp/pages/pdf.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';

import '../utils/contstants.dart';
import '../utils/contstants.dart';

class CallService {
  void call(String number) => launch("tel:$number");
}

GetIt locator = GetIt();

void set() {
  locator.registerSingleton(CallService());
}

class Subject extends StatefulWidget {
  Subject({this.semester, this.subjectCode});
  final int semester;
  final String subjectCode;

  @override
  _SubjectState createState() => _SubjectState();
}

class _SubjectState extends State<Subject> {
  @override
  void initState() {
    super.initState();
  }

  void handleClick(String value) {
    switch (value) {
      case 'Recommended Books':
        recBooks(context);
        break;
      case 'Moderators':
        modno(context);
        break;
    }
  }

  void modno(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            child: Column(
              children: <Widget>[
                Center(
                  child: Icon(Icons.arrow_drop_down),
                ),
                StreamBuilder(
                  stream: Firestore.instance
                      .collection('Subjects')
                      .document('${widget.semester}_${widget.subjectCode}')
                      .snapshots(),
                  builder: (context, snapshot) {
                    List<ListItem> messageWidget = [];
                    if (snapshot.hasData) {
                      List mod = snapshot.data['MODERATORS'];
                      print(mod);
                      for (int i = 0; i < mod.length; i++) {
                        final ctnum = mod[i]['Contact Number'];
                        final name = mod[i]['Name'];

                        ListItem lis =
                            ListItem(heading: 'Name: ', subheaading: name);

                        messageWidget.add(lis);

                        lis = ListItem(
                            heading: 'Contact No. : ', subheaading: ctnum);
                        messageWidget.add(lis);

                        lis = ListItem(phone: true, subheaading: ctnum);
                        messageWidget.add(lis);

                        lis = ListItem(c: true);
                        messageWidget.add(lis);
                      }
                    }
                    return Expanded(
                      child: ListView(
                        children: messageWidget,
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        });
  }

  void recBooks(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            child: Column(
              children: <Widget>[
                Center(
                  child: Icon(Icons.arrow_drop_down),
                ),
                StreamBuilder(
                  stream: Firestore.instance
                      .collection('Subjects')
                      .document('${widget.semester}_${widget.subjectCode}')
                      .snapshots(),
                  builder: (context, snapshot) {
                    List<ListItem> messageWidget = [];
                    if (snapshot.hasData) {
                      List RecBooks = snapshot.data['Recommended Books'];
                      print(RecBooks);

                      for (int i = 0; i < RecBooks.length; i++) {
                        final author = RecBooks[i]['Author'];
                        final booktitle = RecBooks[i]['BookTitle'];
                        final publication = RecBooks[i]['Publication'];

                        ListItem lis = ListItem(
                            heading: '', subheaading: booktitle, b: true);
                        messageWidget.add(lis);

                        lis =
                            ListItem(heading: 'Author : ', subheaading: author);
                        messageWidget.add(lis);

                        lis = ListItem(
                            heading: 'Publication : ',
                            subheaading: publication);

                        messageWidget.add(lis);
                        lis = ListItem(c: true);
                        messageWidget.add(lis);
                      }
                    }
                    return Expanded(
                      child: ListView(
                        children: messageWidget,
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Constants.DARK_SKYBLUE,
          elevation: 0,
          title: Text('${widget.subjectCode}',
              style: TextStyle(
                  fontFamily: 'Montserrat', fontWeight: FontWeight.bold)),
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: handleClick,
              icon: Icon(Icons.info_outline),
              itemBuilder: (BuildContext context) {
                return {'Recommended Books', 'Moderators'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],
          bottom: TabBar(tabs: [
            Tab(
              icon: Icon(Icons.note),
              text: 'Material',
            ),
            Tab(
              icon: Icon(Icons.edit),
              text: 'Q-Paper',
            ),
            Tab(
              icon: Icon(Icons.link),
              text: 'Imp. Links',
            )
          ],
          indicatorColor: Constants.WHITE,
          ),
        ),
        body: TabBarView(
          children: [
            StreamWidget(
              widget: widget,
              typeKey: 'Material',
            ),
            StreamWidget(
              widget: widget,
              typeKey: 'QuestionPapers',
            ),
            StreamWidget(
              widget: widget,
              typeKey: 'Important Links',
            ),
          ],
        ),
      ),
    );
  }
}

class StreamWidget extends StatelessWidget {
  const StreamWidget({Key key, @required this.widget, @required this.typeKey})
      : super(key: key);

  final Subject widget;
  final String typeKey;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection('Subjects')
          .document('${widget.semester}_${widget.subjectCode}')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (typeKey == 'Material') {
            List materialData = snapshot.data['Material'];
            print(materialData.toString());
            List<Widget> listMaterials = [];
            materialData.forEach((element) {
              listMaterials.add(
                Card(
                  child: ListTile(
                    title: Text(element['Title']),
                    leading: IconButton(
                        icon: Icon(Icons.remove_red_eye),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => PDFViewer(
                                    url: element['Content URL'],
                                    sem: widget.semester,
                                    subjectCode: widget.subjectCode,
                                    typeKey: typeKey,
                                    uniqueID: element['id'],
                                    title: element['Title'],
                                  )));
                        }),
                    trailing: IconButton(
                        icon: Icon(Icons.file_download),
                        onPressed: () async {
                          try {
                            String url = element['Content URL'];
                            String dir =
                                (await getApplicationDocumentsDirectory()).path;
                            String path =
                                "$dir/${widget.semester}_${widget.subjectCode}_${typeKey[0]}_${element['id']}_${element['Title']}";
                            if (await File(path).exists()) {
                              print('$path already exists');
                              Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text('File Already Downloaded')));
                            }
                            var request =
                                await HttpClient().getUrl(Uri.parse(url));
                            var response = await request.close();
                            var bytes =
                                await consolidateHttpClientResponseBytes(
                                    response);
                            File file = new File(path);
                            await file.writeAsBytes(bytes).then((value) {
                              print('$path is now downloaded');
                              Scaffold.of(context).showSnackBar(
                                  SnackBar(content: Text('Download Complete')));
                            });
                            return file;
                          } catch (err) {
                            var errorMessage = "Error";
                            print(errorMessage);
                            print(err);
                            return null;
                          }
                        }),
                  ),
                ),
              );
            });
            return Container(child: ListView(children: listMaterials));
          } else if (typeKey == 'QuestionPapers') {
            List materialData = snapshot.data['QuestionPapers'];
            print(materialData.toString());
            List<Widget> listMaterials = [];
            materialData.forEach((element) {
              listMaterials.add(
                Card(
                  child: ListTile(
                    title: Text(element['Title']),
                    subtitle: Text(element['Type'] + '-' + element['Year']),
                    leading: IconButton(
                        icon: Icon(Icons.remove_red_eye),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => PDFViewer(
                                    url: element['URL'],
                                    sem: widget.semester,
                                    subjectCode: widget.subjectCode,
                                    typeKey: typeKey,
                                    uniqueID: element['id'],
                                    title: element['Title'],
                                  )));
                        }),
                    trailing: IconButton(
                        icon: Icon(Icons.file_download),
                        onPressed: () async {
                          try {
                            String url = element['URL'];
                            String dir =
                                (await getApplicationDocumentsDirectory()).path;
                            String path =
                                "$dir/${widget.semester}_${widget.subjectCode}_${typeKey[0]}_${element['id']}_${element['Title']}";
                            if (await File(path).exists()) {
                              print('$path already exists');
                              Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text('File Already Downloaded')));
                            }
                            var request =
                                await HttpClient().getUrl(Uri.parse(url));
                            var response = await request.close();
                            var bytes =
                                await consolidateHttpClientResponseBytes(
                                    response);
                            File file = new File(path);
                            await file.writeAsBytes(bytes).then((value) {
                              print('$path is now downloaded');
                              Scaffold.of(context).showSnackBar(
                                  SnackBar(content: Text('Download Complete')));
                            });
                            return file;
                          } catch (err) {
                            var errorMessage = "Error";
                            print(errorMessage);
                            print(err);
                            return null;
                          }
                        }),
                  ),
                ),
              );
            });
            return Container(child: ListView(children: listMaterials));
          } else if (typeKey == 'Important Links') {
            List materialData = snapshot.data['Important Links'];
            print(materialData.toString());
            List<Widget> listMaterials = [];
            materialData.forEach((element) {
              listMaterials.add(
                Card(
                  child: ListTile(
                    title: Text(element['Title']),
                    trailing: IconButton(
                        icon: Icon(Icons.remove_red_eye),
                        onPressed: () {
                          urlLauncher(element['Content URL']);
                        }),
                  ),
                ),
              );
            });
            return Container(child: ListView(children: listMaterials));
          }
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Future urlLauncher(url) async {
    {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }
}

class ListItem extends StatelessWidget {
  final CallService _service = locator<CallService>();
  @override
  ListItem({this.heading, this.subheaading, this.b, this.c, this.phone});

  String heading;
  String subheaading;
  bool b = false;
  bool c = false;
  bool phone = false;

  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          getWidget(),

//          Text(
//              heading
//          ),
//
//          Text(
//              subheaading
//          ),
        ],
      ),
    );
  }

  Widget getWidget() {
    if (c == true) {
      return SizedBox(
        height: 10.0,
        width: 200.0,
        child: Divider(
          color: Colors.teal,
          height: 50.0,
        ),
      );
    }
    if (phone == true) {
      return Row(
        children: <Widget>[
          IconButton(
              icon: Icon(Icons.call, color: Colors.teal),
              onPressed: () => _service.call(subheaading)),
          IconButton(
              icon: Icon(FontAwesomeIcons.whatsapp, color: Colors.teal),
              onPressed: () {
                FlutterOpenWhatsapp.sendSingleMessage(subheaading, "");
              })
        ],
      );
    }

    if (b == true) {
      return Text(
        subheaading,
        style: TextStyle(
          color: Colors.teal,
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
        ),
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            heading,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          Text(
            subheaading,
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
        ],
      );
    }
  }
}

/*

Container(
          child: StreamBuilder(
            stream: Firestore.instance
                .collection('Subjects')
                .document('${widget.semester}_${widget.subjectCode}')
                .snapshots(),
            builder: (context, snapshot) {
              return Text(snapshot.data['MODERATORS'].toString());
            },
          ),
        ),
*/
