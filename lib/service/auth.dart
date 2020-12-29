import 'package:firebase_auth/firebase_auth.dart';
import 'package:reservation_app/models/user.dart';

import 'database.dart';

class AuthService{

  final FirebaseAuth auth = FirebaseAuth.instance;

  //Create User Object based on Firebase User

  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //auth change user stream

  Stream<User> get newUser{ //This User is our custom user model used in user.dart
    return auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }



  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password, String name) async {
    try {
      AuthResult result = await auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      // create a new document for the user with the uid
      await DatabaseService(uid: user.uid).updateUserData(name);
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }


  //sign out

  signingOut() async{
    try{
      await auth.signOut();
    }catch(e){
      print(e.toString());
    }
  }


}