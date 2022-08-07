import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crowdpoint/dataProvider/appdata.dart';
import 'package:crowdpoint/models/user_model.dart';
import 'package:crowdpoint/screens/home_screen.dart';
import 'package:crowdpoint/services/notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final aadharController = TextEditingController();
RegExp aadhaar = RegExp(r"^[2-9]{1}[0-9]{3}\\s[0-9]{4}\\s[0-9]{4}$");

class AadharCardDialog extends StatefulWidget {
  const AadharCardDialog({Key? key}) : super(key: key);

  @override
  State<AadharCardDialog> createState() => _AadharCardDialogState();
}

class _AadharCardDialogState extends State<AadharCardDialog> {
  String? get errorText {
    // at any time, we can get the text from _controller.value.text
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    // if (!(aadhaar.hasMatch(aadharController.text))) {
    //   return 'Enter valid aadhar no';
    // }
    // if (text.length < 10) {
    //   return 'Too short';
    // }
    // return null if the text is valid
    return null;
  }

  @override
  Widget build(BuildContext context) {
    RegExp aadhaar = RegExp(r"^[2-9]{1}[0-9]{3}\\s[0-9]{4}\\s[0-9]{4}$");

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.white,
      child: Container(
        padding: EdgeInsets.all(15),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Enter your Aadhaar Card number',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 50,
              ),
              TextField(
                  controller: aadharController,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                    errorText: errorText,
                  )),
              SizedBox(
                height: 30,
              ),
              MaterialButton(
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setString('aadhaar', aadharController.text);
                  UserModel user1 =
                      Provider.of<AppData>(context, listen: false).user!;
                  String? token =
                      await getToken(FirebaseAuth.instance.currentUser!.uid);
                  UserModel userModel = UserModel(
                      name: user1.name,
                      email: user1.email,
                      dpurl: user1.dpurl,
                      aadharNo: aadharController.text,
                      messagingToken: token);
                  await FirebaseFirestore.instance
                      .collection("users")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .set(userModel.toMap());
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  color: Colors.blue,
                  child: Text("Save"),
                ),
              )
            ]),
      ),
    );
  }
}
