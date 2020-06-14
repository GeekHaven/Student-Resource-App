import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:studentresourceapp/models/user.dart';
import 'package:studentresourceapp/utils/sharedpreferencesutil.dart';
import 'contstants.dart';

class SignInUtil {
  SignInUtil({this.college, this.batch, this.branch, this.semester});
  String name;
  String email;
  String imageUrl;
  String college;
  int batch;
  int semester;
  String branch;
  String uid;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final _firestoreUser =
      Firestore.instance.collection(Constants.COLLECTION_NAME_USER);

  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult =
        await _firebaseAuth.signInWithCredential(credential);
    final FirebaseUser firebaseuser = authResult.user;

    assert(firebaseuser.email != null);
    assert(firebaseuser.displayName != null);
    assert(firebaseuser.photoUrl != null);
    assert(firebaseuser.uid != null);

    name = firebaseuser.displayName;
    email = firebaseuser.email;
    imageUrl = firebaseuser.photoUrl;
    uid = firebaseuser.uid;

    User user = User();
    user.name = name;
    user.email = email;
    user.imageUrl = imageUrl;
    user.uid = uid;
    user.batch = batch;
    user.branch = branch;
    user.college = college;
    user.semester = semester;

    SharedPreferencesUtil.setBooleanValue(Constants.USER_LOGGED_IN, true);
    SharedPreferencesUtil.setStringValue(Constants.USER_DETAIL_OBJECT, user);
    final userDoc = _firestoreUser.document(uid);
    userDoc.get().then((docsnapshot) => {
          //if (docsnapshot.exists)
          //  {print('Snapshot exists with docID $uid')}
          //else
          //  {
          //print('No existance of doc with docID 123'),
              _firestoreUser.document(uid.toString()).setData({
                'name': name,
                'email': email,
                'imageUrl': imageUrl,
                'uid': uid,
                'batch': batch,
                'branch': branch,
                'college': college,
                'semester': semester,
              })
          //  }
        });

    return 'signInWithGoogle succeeded: $firebaseuser';
  }

  void signOutGoogle() async {
    await googleSignIn.signOut();
    //SharedPreferencesUtil.setBooleanValue(Constants.USER_LOGGED_IN, false);
    SharedPreferencesUtil.clearPreferences();
    print("User Sign Out");
  }
}
