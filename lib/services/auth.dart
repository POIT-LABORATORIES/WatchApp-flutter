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

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
