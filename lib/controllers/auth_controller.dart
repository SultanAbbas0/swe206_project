import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swe206_project/repositories/auth_repository.dart';

final authRepositoryProvider = Provider((_) => AuthRepository());

class AuthController extends Notifier<void> {
  @override
  void build() {}

  Future<void> signIn(String email, String password) async {
    await ref.read(authRepositoryProvider).signInWithEmailAndPassword(email, password);
  }
}

final authControllerProvider =
    NotifierProvider<AuthController, void>(AuthController.new);
