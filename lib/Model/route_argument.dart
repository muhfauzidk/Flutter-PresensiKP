// @dart=2.9

import 'package:absensi/Model/auth.dart';
import 'package:absensi/Model/letter.dart';
import 'package:absensi/Model/success.dart';
import 'package:absensi/Model/user_model.dart';

class RouteArgument {
  final Auth auth;
  final UserModel user;
  final Success success;
  final Letter letter;

  RouteArgument({
    this.auth,
    this.user,
    this.success,
    this.letter,
  });
}