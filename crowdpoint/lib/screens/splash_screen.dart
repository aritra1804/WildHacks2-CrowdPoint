import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:crowdpoint/dataProvider/appdata.dart';
import 'package:crowdpoint/models/user_model.dart';
import 'package:crowdpoint/screens/home_screen.dart';
import 'package:crowdpoint/screens/login_screen.dart';
import 'package:crowdpoint/services/authentication.dart';
import 'package:crowdpoint/services/location_service.dart';
import 'package:crowdpoint/services/notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    var user = await auth.currentUser;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var aadhar = prefs.getString("aadhaar");
    print("Hii");
    print(user);

    if (FirebaseAuth.instance.currentUser != null) {
      user = FirebaseAuth.instance.currentUser;
      Position position = await determinePosition();
      String? token = await getToken(user!.uid);
      UserModel userModel = UserModel(
          name: user.displayName!,
          email: user.email!,
          dpurl: user.photoURL!,
          aadharNo: aadhar,
          messagingToken: token);
      Provider.of<AppData>(context, listen: false).setUser(userModel);
      Provider.of<AppData>(context, listen: false).setPosition(position);

      setState(() {
        _child = HomeScreen();
      });
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
