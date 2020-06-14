import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:studentresourceapp/pages/web.dart';

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
                              builder: (context) =>
                                  Web(url: element['Content URL'])));
                        }),
                    trailing: IconButton(
                        icon: Icon(Icons.file_download), onPressed: null),
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
                              builder: (context) => Web(url: element['URL'])));
                        }),
                    trailing: IconButton(
                        icon: Icon(Icons.file_download), onPressed: null),
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
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  Web(url: element['Content URL'])));
                        }),
                  ),
                ),
              );
            });
            return Container(child: ListView(children: listMaterials));
          }
        }
        return CircularProgressIndicator();
      },
    );
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
