import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:studentresourceapp/components/addButton.dart';
import 'package:studentresourceapp/components/custom_loader.dart';
import 'package:studentresourceapp/components/error_animatedtext.dart';
import 'package:studentresourceapp/components/nocontent_animatedtext.dart';
import 'package:studentresourceapp/utils/contstants.dart';
import 'package:studentresourceapp/utils/unicorndial_edited.dart';

List<Color> _colors = [Constants.DARK_SKYBLUE, Constants.SKYBLUE];
List<double> _stops = [0.0, 1.8];
String selectedOption = 'Materials';

class SubjectsAdmin extends StatefulWidget {
  SubjectsAdmin({this.subjectCode});
  final String subjectCode;
  @override
  _SubjectsAdminState createState() => _SubjectsAdminState();
}

class _SubjectsAdminState extends State<SubjectsAdmin> {
  List<String> list = [
    'Materials',
    'Q - Papers',
    'Imp. Links',
    'Books',
    'Moderators'
  ];
  void addBookBottomSheet(BuildContext context) {
    String bookName;
    String author;
    String publication;
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
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            height: MediaQuery.of(context).size.height / 2 +
                MediaQuery.of(context).viewInsets.bottom,
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
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Add a Book",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Book Name',
                            labelText: 'Book Name',
                          ),
                          onChanged: (value) {
                            bookName = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.red),
                            ),
                            hintText: 'Authors',
                            labelText: 'Authors',
                          ),
                          onChanged: (value) {
                            author = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Publication',
                            labelText: 'Publication',
                          ),
                          onChanged: (value) {
                            publication = value;
                          },
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            {
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
                              }).whenComplete(
                                      () => Navigator.of(context).pop());
                            }
                          },
                          child: AddButton())
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  void addImpLinkBottomSheet(BuildContext context) {
    String title;
    String url;

    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),
        context: context,
        builder: (builder) {
          return Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            height: MediaQuery.of(context).size.height / 2 +
                MediaQuery.of(context).viewInsets.bottom,
            decoration: BoxDecoration(
                color: Constants.WHITE,
                borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(24.0),
                    topRight: const Radius.circular(24.0))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Add the Link",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Title',
                            labelText: 'Title',
                          ),
                          onChanged: (value) {
                            title = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'URL',
                            labelText: 'URL',
                          ),
                          onChanged: (value) {
                            url = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
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
                          },
                          child: AddButton(),
                        ),
                      ),
                    ],
                  ),
                ),
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
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),
        context: context,
        builder: (builder) {
          return Container(
            height: MediaQuery.of(context).size.height / 2 +
                MediaQuery.of(context).viewInsets.bottom,
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            decoration: BoxDecoration(
                color: Constants.WHITE,
                borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(24.0),
                    topRight: const Radius.circular(24.0))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Add QPaper",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Title',
                            labelText: 'Title',
                          ),
                          onChanged: (value) {
                            title = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Exam Type - C1/C2/C3..',
                            labelText: 'Exam Type',
                          ),
                          onChanged: (value) {
                            type = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Year',
                            labelText: 'Year',
                          ),
                          onChanged: (value) {
                            year = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'URL',
                            labelText: 'URL',
                          ),
                          onChanged: (value) {
                            url = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
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
                          },
                          child: AddButton(),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  void addMaterialBottomSheet(BuildContext context) {
    String title;
    String url;
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),
        context: context,
        builder: (builder) {
          return Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            height: MediaQuery.of(context).size.height / 2 +
                MediaQuery.of(context).viewInsets.bottom,
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
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Add Material",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Title',
                            labelText: 'Title',
                          ),
                          onChanged: (value) {
                            title = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'URL',
                            labelText: 'URL',
                          ),
                          onChanged: (value) {
                            url = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
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
                          },
                          child: AddButton(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    print(selectedOption);
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.subjectCode}'),
        actions: [],
      ),
      body: Container(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: DropdownButton(
                iconEnabledColor: Constants.DARK_SKYBLUE,
                underline: ClipRRect(),
                value: selectedOption,
                onChanged: (value) {
                  setState(() {
                    selectedOption = value;
                  });
                },
                items: list.map((item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(
                      item,
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                }).toList(),
              ),
            ),
            StreamBuilder(
              stream: Firestore.instance
                  .collection('Subjects')
                  .document(widget.subjectCode)
                  .snapshots(),
              builder: (context, snapshot) {
                List<Widget> items = [];
                if (snapshot.hasData) {
                  if (selectedOption == 'Materials') {
                    try {
                      List materialData = snapshot.data['Material'];
                      materialData.forEach((element) {
                        items.add(
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 16, left: 16, top: 12),
                            child: Tooltip(
                              message: element['Content URL'],
                              child: Card(
                                shadowColor: Color.fromRGBO(0, 0, 0, 0.75),
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: ListTile(
                                  title: Text(
                                    element['Title'],
                                  ),
                                  subtitle: Text(
                                    "ID: ${element['id'].toString()}",
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red),
                                    onPressed: () {
                                      buildDeleteDialog(
                                          context, 'Material', element);
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                      if (items.isEmpty) {
                        return NoContentAnimatedText();
                      }
                      //items.add(SizedBox(height: 100));
                      return Expanded(
                        child: ListView(
                          children: items,
                        ),
                      );
                    } catch (err) {
                      return ErrorAnimatedText();
                    }
                  } else if (selectedOption == 'Q - Papers') {
                    try {
                      List materialData = snapshot.data['QuestionPapers'];
                      materialData.forEach((element) {
                        items.add(
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 16, left: 16, top: 12),
                            child: Tooltip(
                              message: element['URL'],
                              child: Card(
                                shadowColor: Color.fromRGBO(0, 0, 0, 0.75),
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: ListTile(
                                  title: Text(
                                    element['Title'],
                                  ),
                                  subtitle: Text(
                                    "${element['Type']} ${element['Year']}\nID: ${element['ID'] ?? 'unknown'}",
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red),
                                    onPressed: () {
                                      buildDeleteDialog(
                                          context, 'QuestionPapers', element);
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                      if (items.isEmpty) {
                        return NoContentAnimatedText();
                      }
                      //items.add(SizedBox(height: 100));
                      return Expanded(
                        child: ListView(
                          children: items,
                        ),
                      );
                    } catch (err) {
                      return ErrorAnimatedText();
                    }
                  } else if (selectedOption == 'Imp. Links') {
                    try {
                      List materialData = snapshot.data['Important Links'];
                      materialData.forEach((element) {
                        items.add(
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 16, left: 16, top: 12),
                            child: Tooltip(
                              message: element['Content URL'],
                              child: Card(
                                shadowColor: Color.fromRGBO(0, 0, 0, 0.75),
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: ListTile(
                                  title: Text(
                                    element['Title'],
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red),
                                    onPressed: () {
                                      buildDeleteDialog(
                                          context, 'Important Links', element);
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                      if (items.isEmpty) {
                        return NoContentAnimatedText();
                      }
                      //items.add(SizedBox(height: 100));
                      return Expanded(
                        child: ListView(
                          children: items,
                        ),
                      );
                    } catch (err) {
                      return ErrorAnimatedText();
                    }
                  } else if (selectedOption == 'Books') {
                    try {
                      List materialData = snapshot.data['Recommended Books'];
                      materialData.forEach((element) {
                        items.add(
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 16, left: 16, top: 12),
                            child: Tooltip(
                              message: "Publisher: ${element['Publication']}",
                              child: Card(
                                shadowColor: Color.fromRGBO(0, 0, 0, 0.75),
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: ListTile(
                                  title: Text(
                                    element['BookTitle'],
                                  ),
                                  subtitle: Text('by- ${element['Author']}'),
                                  trailing: IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red),
                                    onPressed: () {
                                      buildDeleteDialog(context,
                                          'Recommended Books', element);
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                      if (items.isEmpty) {
                        return NoContentAnimatedText();
                      }
                      //items.add(SizedBox(height: 100));
                      return Expanded(
                        child: ListView(
                          children: items,
                        ),
                      );
                    } catch (err) {
                      return ErrorAnimatedText();
                    }
                  } else if (selectedOption == 'Moderators') {
                    try {
                      List materialData = snapshot.data['MODERATORS'];
                      materialData.forEach((element) {
                        items.add(
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 16, left: 16, top: 12),
                            child: Tooltip(
                              message: element['uid'],
                              child: Card(
                                shadowColor: Color.fromRGBO(0, 0, 0, 0.75),
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: ListTile(
                                  title: Text(
                                    element['Name'],
                                  ),
                                  subtitle: Text('Contact Number'),
                                  trailing: IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red),
                                    onPressed: () {
                                      buildDeleteDialog(
                                          context, 'MODERATORS', element);
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                      if (items.isEmpty) {
                        return NoContentAnimatedText();
                      }
                      //items.add(SizedBox(height: 100));
                      return Expanded(
                        child: ListView(
                          children: items,
                        ),
                      );
                    } catch (err) {
                      return ErrorAnimatedText();
                    }
                  }
                }
                return CustomLoader();
              },
            ),
          ],
        ),
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

  Future buildDeleteDialog(BuildContext context, String type, element) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(32.0),
          title: Text(
            "⚠ Confirm Delete",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            "Do you really want to delete this item?\nThis can't be undone",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          actions: [
            FlatButton(
                child: Text('Yes'),
                onPressed: () {
                  Firestore.instance
                      .collection('Subjects')
                      .document(widget.subjectCode)
                      .updateData({
                    type: FieldValue.arrayRemove([element])
                  }).then((value) => Navigator.of(context).pop());
                }),
            FlatButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
}
