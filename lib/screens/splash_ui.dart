import 'package:flutter/material.dart';
import 'package:spanticom/theme/colors/light_colors.dart';
import 'package:spanticom/widgets/SplashContent.dart';

class SplashUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SplashContent(),
      ),
    );
  }
}
