import 'package:aichat/homepage.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
        splash: 'asset/splash.png',
        splashIconSize: 400,
        nextScreen: HomePage(),
        splashTransition: SplashTransition.scaleTransition,
        duration: 200,
        backgroundColor: Colors.black,
      ),
    );
  }
}
