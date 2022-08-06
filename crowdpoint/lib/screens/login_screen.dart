import 'package:crowdpoint/screens/home_screen.dart';
import 'package:crowdpoint/services/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: MaterialButton(
        child: Container(
          padding: const EdgeInsets.all(15),
          color: Colors.blue,
          child: Text("Google Sign in"),
        ),
        onPressed: () async {
          User? user = await Authentication.signInWithGoogle(context: context);
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('name', user!.displayName!);
          prefs.setString('email', user.email!);
          prefs.setString('dpUrl', user.photoURL!);

          if (user != null) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => HomeScreen(
                  user: user,
                ),
              ),
            );
          }
        },
      )),
    );
  }
}
