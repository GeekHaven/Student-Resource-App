import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:studentresourceapp/components/custom_loader.dart';
import 'package:studentresourceapp/pages/subjects_admin.dart';

bool canManageModerators = false;

class Admin extends StatefulWidget {
  Admin({this.uid});

  final uid;
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  Future checkModeratorManageAccess() async {
    final QuerySnapshot result =
        await Firestore.instance.collection('admins').getDocuments();
    final List<DocumentSnapshot> documents = result.documents;
    documents.forEach((data) {
      if (data.data['canManageModerators'] == true &&
          data.documentID == widget.uid) {
        setState(() {
          canManageModerators = true;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    checkModeratorManageAccess();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin'),
        ),
      body: Container(
        child: StreamBuilder(
          stream: Firestore.instance
              .collection('admins')
              .document(widget.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              try {
                List subjectAssigned = snapshot.data['subjects_assigned'];
                List<Widget> listMaterials = [];
                subjectAssigned.forEach((element) {
                  listMaterials.add(
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 16, left: 16, top: 12),
                      child: Card(
                        shadowColor: Color.fromRGBO(0, 0, 0, 0.75),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListTile(
                          title: Text(element),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    SubjectsAdmin(
                                        subjectCode: element,
                                        canManageModerators:
                                            canManageModerators),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                });
                listMaterials.add(SizedBox(height: 100));
                return Container(
                  child: ListView(
                    children: listMaterials,
                  ),
                );
              } catch (err) {
                return Center(
                    child: Text('Some error occured.\n Come back later'));
              }
            }
            return CustomLoader();
          },
        ),
      ),
    );
  }
}
