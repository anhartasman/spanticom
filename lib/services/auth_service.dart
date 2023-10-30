import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:spanticom/architectures/domain/entities/UserAccount.dart';

class AuthService extends GetxService {
  Future<AuthService> init() async => this;
  bool isLoggedIn = false;
  UserAccount? theUser;
  bool isAdmin = false;
  void setIsLoggedIn(
    bool newValue, {
    UserAccount? newUser,
  }) {
    isLoggedIn = newValue;
    if (newValue) {
      theUser = newUser;
      isAdmin = newUser!.email == "admin@spanticom.com";
    }
  }

  Future<void> logout() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    await _auth.signOut();
  }
}
