// @dart=2.9

import 'package:absensi/services/user_services.dart';
import 'package:flutter/material.dart';
import 'package:absensi/Model/user_model.dart';


class UserProvider extends ChangeNotifier {
  UserModel _user;

  UserModel get user => _user;

  void loadUser(String uid) async {
    _user = await UserServices.getUser(uid);

    notifyListeners();
  }

}