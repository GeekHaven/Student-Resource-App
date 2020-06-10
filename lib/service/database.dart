import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});
  // all the collection references
   final CollectionReference userDetails = Firestore.instance.collection('userDetails');

  // updating userDetails
  Future updateUserDetails(String name, String branch, String batch) async{
    userDetails.document(uid).setData(
      {
        'name': name,
        'branch': branch,
        'batch': batch,      
      }
    );
  }

}