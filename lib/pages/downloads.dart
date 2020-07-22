import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:studentresourceapp/components/navDrawer.dart';
import 'package:studentresourceapp/models/user.dart';
import 'package:studentresourceapp/utils/contstants.dart';
import 'package:studentresourceapp/utils/sharedpreferencesutil.dart';
import 'package:studentresourceapp/pages/pdf.dart';

class Downloads extends StatefulWidget {
  @override
  _DownloadsState createState() => _DownloadsState();
}

class _DownloadsState extends State<Downloads> {
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

  void _listofFiles() async {
    directory = (await getApplicationDocumentsDirectory()).path;
    setState(() {
      file = Directory("$directory").listSync();
      file.removeWhere((element) {
        dynamic filename = element.toString().substring(
            element.toString().lastIndexOf('/') + 1,
            element.toString().lastIndexOf('\''));
        if (filename.startsWith(RegExp(r'([0-9])\_[A-Z]\w'))) {
          //print('correct file type found');
          return false;
        } else {
          //print('expected file name not found. removing it...');
          return true;
        }
      });
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
    _listofFiles();
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
      appBar: AppBar(
        title: Text('Downloads'),
      ),
      body: Container(
        child: file.length == 0
            ? Center(
                child: Text('No downloads'),
              )
            : Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      itemCount: file.length,
                      itemBuilder: (BuildContext context, int index) {
                        String path = file[index].toString();
                        String modifiedPath = modifyPath(path);
                        String filename = modifiedPath
                            .substring(modifiedPath.lastIndexOf('/') + 1);
                        var arr = filename.split('_');
                        int uniqueId = int.parse(arr[3]);
                        int sem = int.parse(arr[0]);
                        String subjectcode = arr[1];
                        String typeKey = arr[2];
                        String title = arr[4];
                        return Padding(
                          padding: const EdgeInsets.only(
                              right: 16, left: 16, top: 12),
                          child: Card(
                            shadowColor: Color.fromRGBO(0, 0, 0, 0.75),
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ListTile(
                              leading: IconButton(
                                icon: ImageIcon(
                                  AssetImage('assets/svgIcons/preview.png'),
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => PDFViewer(
                                        sem: sem,
                                        url: '',
                                        subjectCode: subjectcode,
                                        typeKey: typeKey,
                                        uniqueID: uniqueId,
                                        title: title,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              title: Text(
                                title,
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              subtitle: Text(
                                  "$sem/$subjectcode/${typeKey == 'M' ? 'Material' : 'Q-Paper'}"),
                              trailing: IconButton(
                                icon: Icon(Icons.delete,
                                    color: Colors.red, size: 24),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        contentPadding: EdgeInsets.all(32.0),
                                        title: Text(
                                          "⚠ Confirm Delete",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        content: Text(
                                          "Do you really want to delete this item?",
                                          style: TextStyle(
                                            fontSize: 20.0,
                                          ),
                                        ),
                                        actions: [
                                          FlatButton(
                                            child: Text(
                                              "Yes",
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                            onPressed: () async {
                                              try {
                                                if (await File(modifiedPath)
                                                    .exists()) {
                                                  //print('Path exists');
                                                  File(modifiedPath)
                                                      .deleteSync();
                                                  List temp = file;
                                                  temp.removeWhere((element) =>
                                                      element == file[index]);
                                                  setState(() {
                                                    file = temp;
                                                  });
                                                }
                                              } catch (err) {
                                                //print(err);
                                              }
                                              Navigator.of(context).pop(true);
                                            },
                                          ),
                                          FlatButton(
                                            child: Text(
                                              "No",
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop(true);
                                            },
                                          )
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  String modifyPath(String path) {
    return path.substring(path.indexOf('/'), path.lastIndexOf('\''));
  }
}
