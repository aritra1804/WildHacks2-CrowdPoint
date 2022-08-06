import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:crowdpoint/screens/home_screen.dart';
import 'package:crowdpoint/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Widget _child = LoginScreen();
  @override
  void initState() {
    checkUserLogin();
    super.initState();
  }

  checkUserLogin() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final user = await auth.currentUser;
    print(user);
    if (user != null) {
      _child = HomeScreen(user: user);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: 'assets/cp_logo.png',
      splashIconSize: 350,
      pageTransitionType: PageTransitionType.fade,
      nextScreen: _child,
    );
  }
}
