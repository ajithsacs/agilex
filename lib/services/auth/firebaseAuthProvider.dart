import 'package:agilex/services/auth/authexception.dart';
import 'package:agilex/services/auth/authprovider.dart';
import 'package:agilex/services/auth/user_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../constants/response.dart';

class FirebaseAuthProvider implements AuthProvider {
  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      final user = currentUser;
      if (user != null) {
        return user;
      } else {
        throw UserNotLogined();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == emailAlreadyInUse) {
        throw EmailAlreadyInUse();
      } else if (e.code == weekpassword) {
        throw WeekpasswordAuthException();
      } else {
        throw GenericAuthException();
      }
    } catch (e) {
      throw GenericAuthException();
    }
  }

  @override
  AuthUser? get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return AuthUser.fromfirebase(user);
    } else {
      return null;
    }
  }

  @override
  Future<AuthUser> login(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user= currentUser;
      if(user!=null)
      {
        return user;
      }
      else{
        throw UserNotLogined();
      }

    } on FirebaseAuthException catch(e)
    {
      if (e.code == usernotfound) {
        throw EmailnotFound();
   
    } else if (e.code == wrongpassword) {
      throw WeekpasswordAuthException();
     
    } else if (e.code == networkerror) {
      throw NetworkNotFoundException();
     
    } else {
      throw GenericAuthException();
    }
      
    } 

    catch (e) {
      throw GenericAuthException();
    }
  }

  @override
  Future<void> logout() async{
    final user=currentUser;
    if(user!=null)
    {
      await FirebaseAuth.instance.signOut();
    }
    else{
      throw UserNotLogined();
    }
  }

  @override
  Future<void> sendEmailverification() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.sendEmailVerification();
    } else {
      throw UserNotLogined();
    }
  }
}
