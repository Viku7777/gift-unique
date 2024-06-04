import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  static FirebaseAuth fAuth = FirebaseAuth.instance;

  Future<UserCredential> login(String email, String password) async {
    try {
      return await fAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw e.message!;
    }
  }

  Future<UserCredential> createAccount(String email, String password) async {
    try {
      return await fAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw e.message!;
    }
  }

  Future<void> forgotPassword(
    String email,
  ) async {
    try {
      return await fAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw e.message!;
    }
  }
}
