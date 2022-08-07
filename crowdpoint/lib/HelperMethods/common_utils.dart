import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class CommonUtils {
  static SnackBar customSnackBar({required String content}) {
    return SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        content,
        style: TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
      ),
    );
  }

  static Future<String?> uploadToFirebase(File file, String path) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    String? downloadURL;

    Reference ref = FirebaseStorage.instance.ref('complaints/$path');
    try {
      await ref.putFile(file);

      downloadURL = await ref.getDownloadURL();
      // print(downloadURL);
      return downloadURL;
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      print(e.message);
    }
  }
}
