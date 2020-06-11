import 'package:firebase_auth/firebase_auth.dart';
import 'package:studentresourceapp/model/user.dart';
import 'package:studentresourceapp/service/database.dart';
class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
        .map((FirebaseUser user) => _convertFirebaseUserToUser(user));
  }


  //convert firebase user to own user
  User _convertFirebaseUserToUser(FirebaseUser user)
  {
    return user != null ? User(uid: user.uid) : null;
  }

  // sign in using email and password
  Future signIn(String email, String password) async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser fbUser = result.user;
      return _convertFirebaseUserToUser(fbUser);

    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // register using email and password
  Future register(String email, String password, String name, String branch, String batch, String college, String semester) async {
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser fbUser = result.user;
      await DatabaseService(uid: fbUser.uid).updateUserDetails(name, branch, batch, college, semester);
      return _convertFirebaseUserToUser(fbUser);

    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign out

  Future signOut() async {
    return await _auth.signOut();
  }



}