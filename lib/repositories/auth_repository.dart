import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth auth = FirebaseAuth.instance;
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
