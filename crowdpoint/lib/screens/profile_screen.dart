import 'package:crowdpoint/models/user_model.dart';
import 'package:crowdpoint/screens/login_screen.dart';
import 'package:crowdpoint/services/authentication.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class ProfilePage extends StatefulWidget {
  UserModel user;
  ProfilePage({Key? key, required this.user}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    print(widget.user);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kL1Color,
        foregroundColor: kBlackColor,
        elevation: 1,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
          ),
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
        ),
        title: Text(
          "Profile",
          style: TextStyle(
            fontFamily: "Quicksand",
          ),
        ),
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
            child: Column(
          children: [
            SizedBox(
              height: 16,
            ),
            CircleAvatar(
              foregroundImage: NetworkImage(
                widget.user.dpurl,
              ),
              backgroundColor: Colors.grey,
              radius: size.width * 0.15,
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              widget.user.name,
              style: TextStyle(
                fontSize: size.width * 0.07,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              widget.user.email,
              style: TextStyle(fontSize: size.width * 0.05, color: Colors.grey),
            ),
            Text(
              widget.user.aadharNo.toString(),
              style: TextStyle(fontSize: size.width * 0.05, color: Colors.grey),
            ),
            SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () {
                Authentication.signOut(context: context);
                Navigator.popUntil(context, (route) => false);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
              child: Text(
                "Logout",
                style: TextStyle(fontSize: size.width * 0.04),
              ),
            )
          ],
        )),
      ),
    );
  }
}
