import 'package:absensi/Admin/Screens/admin_detail_users_screen.dart';
import 'package:absensi/Admin/Screens/admin_main_screen.dart';
import 'package:absensi/Admin/Screens/admin_presence_screen.dart';
import 'package:absensi/Admin/Screens/admin_users_data_screen.dart';
import 'package:absensi/Screens/check_in_screen.dart';
import 'package:absensi/Screens/check_out_screen.dart';
import 'package:absensi/Screens/forgot_password_view.dart';
import 'package:absensi/Screens/formregist_screen.dart';
import 'package:absensi/Screens/login_screen.dart';
import 'package:absensi/Screens/main_screen.dart';
import 'package:absensi/Screens/splash_screen.dart';
import 'package:absensi/Screens/update_profile_view.dart';
import 'package:absensi/Screens/detail_presence_screen.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> routes = {
  checkInScreen.routeName: (context) => checkInScreen(),
  CheckOutScreen.routeName: (context) => CheckOutScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  AdminAllPresenceView.routeName: (context) => AdminAllPresenceView(),
  UsersDataScreen.routeName: (context) => UsersDataScreen(),
  DetailUsersScreen.routeName: (context) => DetailUsersScreen(),
  splashScreen.routeName: (context) => splashScreen(),
  DetailPresenceScreen.routeName: (context) => DetailPresenceScreen(),
  formRegister.routeName: (context) => formRegister(),
  UpdateProfileScreen.routeName: (context) => UpdateProfileScreen(),
  MainScreen.routeName: (context) => MainScreen(),
  AdminMainScreen.routeName: (context) => AdminMainScreen(),
  LoginScreen.routeName: (context) => LoginScreen(),
};
