import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:studentresourceapp/pages/pdf.dart';
import 'package:url_launcher/url_launcher.dart';

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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('${widget.subjectCode}'),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.info_outline), onPressed: null)
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
          ]),
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
