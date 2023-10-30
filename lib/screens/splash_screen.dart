import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spanticom/routes/app_routes.dart';
import 'package:spanticom/screens/SplashCheckAuth.dart';
import 'package:spanticom/screens/SplashCheckPermission.dart';
import 'package:spanticom/theme/colors/light_colors.dart';
import 'package:spanticom/widgets/SplashContent.dart';

class splash_screen extends StatefulWidget {
  @override
  State<splash_screen> createState() => _splash_screenState();
}

class _splash_screenState extends State<splash_screen> {
  bool needPermission = true;
  bool needAuth = true;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    if (needPermission) {
      // checkUserPermission();
      return SplashCheckPermission(
          onSuccess: () => setState(() => needPermission = false));
    }

    if (needAuth) {
      return SplashCheckAuth(onSuccess: () => setState(() => needAuth = false));
    }
    Future.delayed(Duration(milliseconds: 500))
        .then((value) => Get.offNamed(Routes.homeMenuRoute));

    return Scaffold(
      backgroundColor: Colors.white,
      body: SplashContent(),
    );
  }
}
