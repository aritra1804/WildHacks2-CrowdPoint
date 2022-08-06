import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

class AppData extends ChangeNotifier {
  User? user;
  Position? position;

  setPosition(Position _position) {
    position = _position;
    notifyListeners();
  }
}
