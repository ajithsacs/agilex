import 'package:agilex/services/auth/authprovider.dart';
import 'package:agilex/services/auth/user_auth.dart';

class AuthServices implements AuthProvider {
  final AuthProvider provider;
  AuthServices(this.provider);

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  })=>provider.createUser(email:email,password:password) ;

  @override
  // TODO: implement currentUser
  AuthUser? get currentUser =>provider.currentUser;

  @override
  Future<AuthUser> login({
    required String email,
    required String password,
  }) =>provider.login(email: email, password: password);
  

  @override
  Future<void> logout()=>provider.logout();

  @override
  Future<void> sendEmailverification()=>provider.sendEmailverification(); 
}
