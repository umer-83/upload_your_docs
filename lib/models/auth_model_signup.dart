import 'package:firebase_auth/firebase_auth.dart';

class AuthServiceSignUp {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> signUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential.user?.uid;
    } catch (e) {
      // ignore: avoid_print
      print('Error signing up: $e');
      return Future.error(e.toString());
    }
  }
}
