import 'package:absensi/Screens/login_screen.dart';
import 'package:absensi/Screens/main_screen.dart';
import 'package:absensi/provider/history_provider.dart';
import 'package:absensi/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class Wrapper extends StatelessWidget {
  static String routeName = '/wrapper';

  @override
  Widget build(BuildContext context) {
    auth.User firebaseUser = Provider.of<auth.User>(context);

    if (firebaseUser == null) {
      return Scaffold(
        body: LoginScreen(),
      );
    }
    else {
      Provider.of<UserProvider>(context).loadUser(firebaseUser.uid);
      Provider.of<HistoryProvider>(context).loadHistory(firebaseUser.uid);

      return Scaffold(
        body: MainScreen(),
      );
    }
  }
}
