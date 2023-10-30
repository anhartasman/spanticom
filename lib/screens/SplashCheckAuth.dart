import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:spanticom/architectures/domain/entities/UserAccount.dart';
import 'package:spanticom/architectures/domain/entities/UserProfile.dart';
import 'package:spanticom/screens/splash_ui.dart';
import 'package:spanticom/services/auth_service.dart';

class SplashCheckAuth extends StatefulWidget {
  final Function onSuccess;
  const SplashCheckAuth({
    Key? key,
    required this.onSuccess,
  }) : super(key: key);
  @override
  _SplashCheckAuthState createState() => _SplashCheckAuthState();
}

class _SplashCheckAuthState extends State<SplashCheckAuth> {
  @override
  void initState() {
    // set status bar color to transparent and navigation bottom color to black21
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );

    checkIfUserLoggedIn();
    super.initState();
  }

  void checkIfUserLoggedIn() async {
    final authService = Get.find<AuthService>();
    FirebaseAuth _auth = FirebaseAuth.instance;
    final theUser = await _auth.currentUser;
    if (theUser == null) {
      authService.setIsLoggedIn(false);
    } else {
      authService.setIsLoggedIn(
        true,
        newUser: UserAccount(
          id: theUser.uid,
          email: theUser.email ?? "",
          profil: UserProfile(
            nama: theUser.displayName ?? "",
            foto: theUser.photoURL ?? "",
          ),
          phone: theUser.phoneNumber ?? "",
        ),
      );
    }
    widget.onSuccess();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SplashUI();
  }
}
