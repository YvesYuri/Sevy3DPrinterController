import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthenticationServices extends GetxService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();

  User? get currentUser => firebaseAuth.currentUser;

  Future<(User?, String?)> signIn(
      String email, String password) async {
    try {
      var result = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return (result.user, null);
    } on FirebaseAuthException catch (e) {
      return (null, e.code);
    }
  }

  Future<(User?, String?)> signUp(
      String email, String password, String displayName) async {
    try {
      var result = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await firebaseAuth.currentUser!.updateDisplayName(displayName);
      return (result.user, null);
    } on FirebaseAuthException catch (e) {
      return (null, e.code);
    }
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  Future<String?> forgotPassword(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }
}
