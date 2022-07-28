import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/cupertino.dart';
@immutable
class AuthUser
{ 
  final bool isEmailverifyed;
  const AuthUser(this.isEmailverifyed);
  factory AuthUser.fromfirebase(User user)=>AuthUser(user.emailVerified);
}


