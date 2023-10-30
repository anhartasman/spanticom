import 'package:flutter/material.dart';
import 'package:spanticom/theme/colors/light_colors.dart';

class SplashContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double appHeight = MediaQuery.of(context).size.height;
    return Center(
      child: Image.asset(
        "assets/icon/app_icon.png",
      ),
    );
  }
}
