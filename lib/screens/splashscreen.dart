import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';

import 'loginscreen.dart';
import 'measuresscreen.dart';

String? userID;

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      nextScreen: userID != null ? const MeasuresScreen() : const LoginScreen(),
      splash: Image.asset('assets/images/logo.jpg'),
      duration: 1000,
      splashIconSize: 200,
      backgroundColor: Colors.white,
    );
  }
}
