import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:crowdpoint/dataProvider/appdata.dart';
import 'package:crowdpoint/screens/home_screen.dart';
import 'package:crowdpoint/screens/login_screen.dart';
import 'package:crowdpoint/services/location_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

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
    print("Hii");
    print(user);
    if (user != null) {
      _child = HomeScreen(user: user);
      setState(() {});
      Position position = await determinePosition();
      Provider.of<AppData>(context, listen: false).setPosition(position);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: 'assets/cp_logo.png',
      splashIconSize: 350,
      duration: 4000,
      pageTransitionType: PageTransitionType.fade,
      nextScreen: _child,
    );
  }
}
