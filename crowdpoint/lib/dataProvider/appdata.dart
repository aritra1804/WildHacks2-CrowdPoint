import 'package:crowdpoint/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

class AppData extends ChangeNotifier {
  UserModel? user;
  Position? position;

  setUser(UserModel _user) {
    user = _user;
    notifyListeners();
  }

  setPosition(Position _position) {
    position = _position;
    notifyListeners();
  }
}
