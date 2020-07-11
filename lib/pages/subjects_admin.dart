import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:studentresourceapp/utils/contstants.dart';
import 'package:studentresourceapp/utils/unicorndial_edited.dart';

class SubjectsAdmin extends StatefulWidget {
  SubjectsAdmin({this.subjectCode});
  final String subjectCode;
  @override
  _SubjectsAdminState createState() => _SubjectsAdminState();
}

class _SubjectsAdminState extends State<SubjectsAdmin> {
  void addBookBottomSheet(BuildContext context) {
    String bookName;
    String author;
    String publication;
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),
        context: context,
        builder: (builder) {
          return Container(
            decoration: BoxDecoration(
                color: Constants.WHITE,
                borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(24.0),
                    topRight: const Radius.circular(24.0))),
            child: Column(
              children: <Widget>[
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
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Book Name',
                    labelText: 'Book Name',
                  ),
                  onChanged: (value) {
                    bookName = value;
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Authors',
                    labelText: 'Authors',
                  ),
                  onChanged: (value) {
                    author = value;
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Publication',
                    labelText: 'Publication',
                  ),
                  onChanged: (value) {
                    publication = value;
                  },
                ),
                IconButton(
                    icon: Icon(Icons.check),
                    onPressed: () {
                      Firestore.instance
                          .collection('Subjects')
                          .document(widget.subjectCode)
                          .updateData({
                        'Recommended Books': FieldValue.arrayUnion([
                          {
                            'BookTitle': bookName,
                            'Author': author,
                            'Publication': publication
                          }
                        ])
                      }).whenComplete(() => Navigator.of(context).pop());
                    })
              ],
            ),
          );
        });
  }

  void addImpLinkBottomSheet(BuildContext context) {
    String title;
    String url;

    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),
        context: context,
        builder: (builder) {
          return Container(
            decoration: BoxDecoration(
                color: Constants.WHITE,
                borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(24.0),
                    topRight: const Radius.circular(24.0))),
            child: Column(
              children: <Widget>[
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
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Title',
                    labelText: 'Title',
                  ),
                  onChanged: (value) {
                    title = value;
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'URL',
                    labelText: 'URL',
                  ),
                  onChanged: (value) {
                    url = value;
                  },
                ),
                IconButton(
                    icon: Icon(Icons.check),
                    onPressed: () {
                      Firestore.instance
                          .collection('Subjects')
                          .document(widget.subjectCode)
                          .updateData({
                        'Important Links': FieldValue.arrayUnion([
                          {
                            'Content URL': url,
                            'Title': title,
                          }
                        ])
                      }).whenComplete(() => Navigator.of(context).pop());
                    })
              ],
            ),
          );
        });
  }

  void addQPapersBottomSheet(BuildContext context) {
    String title;
    String type;
    String year;
    String url;
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),
        context: context,
        builder: (builder) {
          return Container(
            decoration: BoxDecoration(
                color: Constants.WHITE,
                borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(24.0),
                    topRight: const Radius.circular(24.0))),
            child: Column(
              children: <Widget>[
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
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Title',
                    labelText: 'Title',
                  ),
                  onChanged: (value) {
                    title = value;
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Exam Type - C1/C2/C3..',
                    labelText: 'Exam Type',
                  ),
                  onChanged: (value) {
                    type = value;
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Year',
                    labelText: 'Year',
                  ),
                  onChanged: (value) {
                    year = value;
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'URL',
                    labelText: 'URL',
                  ),
                  onChanged: (value) {
                    url = value;
                  },
                ),
                IconButton(
                    icon: Icon(Icons.check),
                    onPressed: () {
                      Firestore.instance
                          .collection('Subjects')
                          .document(widget.subjectCode)
                          .updateData({
                        'QuestionPapers': FieldValue.arrayUnion([
                          {
                            'Title': title,
                            'Type': type,
                            'URL': url,
                            'Year': year
                          }
                        ])
                      }).whenComplete(() => Navigator.of(context).pop());
                    })
              ],
            ),
          );
        });
  }

  void addMaterialBottomSheet(BuildContext context) {
    String title;
    String url;
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),
        context: context,
        builder: (builder) {
          return Container(
            decoration: BoxDecoration(
                color: Constants.WHITE,
                borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(24.0),
                    topRight: const Radius.circular(24.0))),
            child: Column(
              children: <Widget>[
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
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Title',
                    labelText: 'Title',
                  ),
                  onChanged: (value) {
                    title = value;
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'URL',
                    labelText: 'URL',
                  ),
                  onChanged: (value) {
                    url = value;
                  },
                ),
                IconButton(
                    icon: Icon(Icons.check),
                    onPressed: () {
                      Firestore.instance
                          .collection('Subjects')
                          .document(widget.subjectCode)
                          .updateData({
                        'Material': FieldValue.arrayUnion([
                          {
                            'Title': title,
                            'Content URL': url,
                          }
                        ])
                      }).whenComplete(() => Navigator.of(context).pop());
                    })
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.subjectCode}'),
      ),
      floatingActionButton: UnicornDialer(
        hasNotch: true,
        mainAnimationDuration: 300,
        animationDuration: 230,
        parentButton: Icon(Icons.add_circle_outline),
        finalButtonIcon: Icon(Icons.close),
        childPadding: 12,
        backgroundColor: Colors.white70,
        parentButtonBackground: Constants.DARK_SKYBLUE,
        childButtons: [
          UnicornButton(
            labelText: 'Books',
            labelColor: Colors.black,
            hasLabel: true,
            currentButton: FloatingActionButton(
              heroTag: null,
              mini: true,
              onPressed: () {
                addBookBottomSheet(context);
              },
              backgroundColor: Constants.DARK_SKYBLUE,
              child:
                  ImageIcon(AssetImage('assets/svgIcons/book.png'), size: 20),
            ),
          ),
          UnicornButton(
            labelText: 'Important Links',
            labelColor: Colors.black,
            hasLabel: true,
            currentButton: FloatingActionButton(
              heroTag: null,
              mini: true,
              onPressed: () {
                addImpLinkBottomSheet(context);
              },
              backgroundColor: Constants.DARK_SKYBLUE,
              child:
                  ImageIcon(AssetImage('assets/svgIcons/link.png'), size: 20),
            ),
          ),
          UnicornButton(
            labelText: 'Material',
            labelColor: Colors.black,
            hasLabel: true,
            currentButton: FloatingActionButton(
              heroTag: null,
              mini: true,
              onPressed: () {
                addMaterialBottomSheet(context);
              },
              backgroundColor: Constants.DARK_SKYBLUE,
              child: Icon(Icons.note_add),
            ),
          ),
          UnicornButton(
            labelText: 'Question Papers',
            labelColor: Colors.black,
            hasLabel: true,
            currentButton: FloatingActionButton(
              heroTag: null,
              mini: true,
              onPressed: () {
                addQPapersBottomSheet(context);
              },
              backgroundColor: Constants.DARK_SKYBLUE,
              child:
                  ImageIcon(AssetImage('assets/svgIcons/pencil.png'), size: 20),
            ),
          ),
        ],
      ),
    );
  }
}
