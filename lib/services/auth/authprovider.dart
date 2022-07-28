import 'package:agilex/services/auth/user_auth.dart';

abstract class AuthProvider {
  Future<void> init();
  AuthUser? get currentUser;
  Future<AuthUser> login({
    required String email,
    required String password,
  });

  Future<AuthUser> createUser({
    required String email,
    required String password,
  });
  Future<void> logout();
  Future<void> sendEmailverification();
}
