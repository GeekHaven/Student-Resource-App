import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:studentresourceapp/utils/contstants.dart';
import 'package:studentresourceapp/utils/unicorndial_edited.dart';
List<Color> _colors = [Constants.DARK_SKYBLUE, Constants.SKYBLUE];
List<double> _stops = [0.0, 1.8];

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
            height: MediaQuery.of(context).size.height / 2 +
                MediaQuery.of(context).viewInsets.bottom,
            decoration: BoxDecoration(
                color: Constants.WHITE,
                borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(24.0),
                    topRight: const Radius.circular(24.0))),
            child: ListView(
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
                    child: Text("Add a Book",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),),
                  ),
                ),
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

                  onTap: ()
                  {
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
                      }).whenComplete(() => Navigator.of(context).pop());
                    }


                  },
                  child: Padding(

                    padding: EdgeInsets.all(36.0),
                    child: Container(

                      height:50.0,
                      width: 120.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        gradient: LinearGradient(
                          colors: _colors,
                          stops: _stops,

                        )
                        ,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [

                            Text("Add",style: TextStyle(color :Colors.white,fontSize: 20.0,fontWeight: FontWeight.bold),),
                            Spacer(),
                            Icon(Icons.arrow_forward_ios,color: Colors.white,

                            )
                          ],
                        ),
                      ),

                    ),

                  ),
                )
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
            height: MediaQuery.of(context).size.height / 2 +
                MediaQuery.of(context).viewInsets.bottom,
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
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("Add the Link",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),),
                  ),
                ),
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

                    onTap: ()
                    {
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
                    child: Padding(

                      padding: EdgeInsets.all(36.0),
                      child: Container(

                        height:50.0,
                        width: 120.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          gradient: LinearGradient(
                            colors: _colors,
                            stops: _stops,

                          )
                          ,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [

                              Text("Add",style: TextStyle(color :Colors.white,fontSize: 20.0,fontWeight: FontWeight.bold),),
                              Spacer(),
                              Icon(Icons.arrow_forward_ios,color: Colors.white,

                              )
                            ],
                          ),
                        ),

                      ),

                    ),
                  ),
                )
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
            decoration: BoxDecoration(
                color: Constants.WHITE,
                borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(24.0),
                    topRight: const Radius.circular(24.0))),
            child: ListView(
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
                    child: Text("Add QPaper",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),),
                  ),
                ),
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

                    onTap: ()
                    {
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
                    child: Padding(

                      padding: EdgeInsets.all(36.0),
                      child: Container(

                        height:50.0,
                        width: 120.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          gradient: LinearGradient(
                            colors: _colors,
                            stops: _stops,

                          )
                          ,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [

                              Text("Add",style: TextStyle(color :Colors.white,fontSize: 20.0,fontWeight: FontWeight.bold),),
                              Spacer(),
                              Icon(Icons.arrow_forward_ios,color: Colors.white,

                              )
                            ],
                          ),
                        ),

                      ),

                    ),
                  ),
                )

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
            height: MediaQuery.of(context).size.height / 2 +
                MediaQuery.of(context).viewInsets.bottom,
            decoration: BoxDecoration(
                color: Constants.WHITE,
                borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(24.0),
                    topRight: const Radius.circular(24.0))),
            child: ListView(
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
                    child: Text("Add Material",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),),
                  ),
                ),
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

                    onTap: ()
                    {
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
                    child: Padding(

                      padding: EdgeInsets.all(36.0),
                      child: Container(

                        height:50.0,
                        width: 120.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          gradient: LinearGradient(
                            colors: _colors,
                            stops: _stops,

                          )
                          ,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [

                              Text("Add",style: TextStyle(color :Colors.white,fontSize: 20.0,fontWeight: FontWeight.bold),),
                              Spacer(),
                              Icon(Icons.arrow_forward_ios,color: Colors.white,

                              )
                            ],
                          ),
                        ),

                      ),

                    ),
                  ),
                )
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
