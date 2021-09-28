import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication {
  final FirebaseAuth _firebaseAuth;
  static String UID = "";
  Authentication(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.idTokenChanges();
  User getUSer() {
    return _firebaseAuth.currentUser!;
  }

  Future<void> signOut() async {
    if (_firebaseAuth.currentUser!.isAnonymous) {
      _firebaseAuth.currentUser!.delete();
    }
    await _firebaseAuth.signOut();
  }

  Future<String?> signInWithGoogle() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User user;
    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      try {
        final UserCredential userCredential = await auth.signInWithCredential(credential);

        user = userCredential.user!;
        if (!user.emailVerified) {
          user.sendEmailVerification();
          signOut();
          return "Please confirm your email address";
        } else {
          UID = _firebaseAuth.currentUser!.uid;
          return "true";
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          return e.message;
        } else if (e.code == 'invalid-credential') {
          return e.message;
        }
        return e.message;
      } catch (e) {
        print(e);
      }
    }
  }

  Future<String?> signIn({required String email, required String password}) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      if (userCredential.user != null) {
        UID = _firebaseAuth.currentUser!.uid;
        return "true";
      }
      /*if (!userCredential.user!.emailVerified) {
        signOut();
        return "Please confirm your email address";
      } else {
        UID = _firebaseAuth.currentUser!.uid;
        return "true";
      }*/
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return e.message;
    }
  }
}
