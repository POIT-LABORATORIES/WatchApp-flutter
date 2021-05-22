import 'package:firebase_auth/firebase_auth.dart';
import 'package:watchapp/models/user.dart' as localUser;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  localUser.User _userFromFirebaseUser(User user) {
    return user != null ? localUser.User(uid: user.uid) : null;
  }

  Stream<localUser.User> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  Future signInAnon() async {
    try {
      UserCredential userCredential = await _auth.signInAnonymously();
      return _userFromFirebaseUser(userCredential.user);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return _userFromFirebaseUser(userCredential.user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user';
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return _userFromFirebaseUser(userCredential.user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email';
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
