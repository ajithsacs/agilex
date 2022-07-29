import 'package:agilex/services/auth/authexception.dart';
import 'package:agilex/services/auth/authprovider.dart';
import 'package:agilex/services/auth/user_auth.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Moke authentication", () {
    final provider = MockeAuthProvider();
    test("Not initialzed at begine", () {
      expect(provider.isinitilazed, false);
    });
    test("Can not Logout without initalzed", () {
      expect(provider.logout(),
          throwsA(const TypeMatcher<NotInitializeException>()));
    });

    test("should be abile to initialized", () async {
      await provider.init();
      expect(provider.isinitilazed, true);
    });

    test("user should be null after initialized", () {
      expect(provider.currentUser, null);
    });

    test("should be initilazed with in 2 sec", () async {
      await provider.init();
      expect(provider.isinitilazed, true);
    });

    test("create user should be delegeted to function ", () async {
      final baduser =
          provider.createUser(email: "ajith@gamil", password: "sdjdfkdksd");
      expect(baduser, throwsA(const TypeMatcher<EmailnotFoundException>()));
      final badpassworduser =
          provider.createUser(email: "ath03@gamil.com", password: 'aaaaa');
      expect(badpassworduser,
          throwsA(const TypeMatcher<WeekpasswordAuthException>()));
      final user = await provider.createUser(
          email: "ajithias03@gamil.com", password: "23e223224");
      expect(provider.currentUser, user);
      expect(user.isEmailverifyed, false);
    });
  });
}

class NotInitializeException implements Exception {}

class MockeAuthProvider implements AuthProvider {
  AuthUser? _authUser;

  var _isinitialzed = false;
  bool get isinitilazed => _isinitialzed;
  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) async {
    if (!isinitilazed) throw NotInitializeException();
    await Future.delayed(const Duration(seconds: 1));
    return login(
      email: email,
      password: password,
    );
  }

  @override
  AuthUser? get currentUser => _authUser;

  @override
  Future<void> init() async {
    await Future.delayed(const Duration(seconds: 1));
    _isinitialzed = true;
  }

  @override
  Future<AuthUser> login(
      {required String email, required String password}) async {
    if (!isinitilazed) throw NotInitializeException();
    await Future.delayed(const Duration(seconds: 1));
    if (email == "ajith@gamil") throw EmailnotFoundException();
    if (password == "12345") throw WeekpasswordAuthException();
    const user = AuthUser(isEmailverifyed: false);
    _authUser = user;
    return Future.value(user);
  }

  @override
  Future<void> logout() async {
    if (!isinitilazed) throw NotInitializeException();
    if (_authUser == null) throw UserNotLogined();
    Future.delayed(const Duration(seconds: 1));
    _authUser = null;
  }

  @override
  Future<void> sendEmailverification() async {
    if (!isinitilazed) throw NotInitializeException();
    if (_authUser == null) throw UserNotLogined();
    const newuser = AuthUser(isEmailverifyed: true);
    _authUser = newuser;
  }
}
