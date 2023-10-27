// @dart=2.9

import 'package:absensi/Model/auth.dart';
import 'package:absensi/Model/user_model.dart';
import 'package:absensi/Model/response_handler.dart';
import 'package:absensi/extensions/firebase_user_extension.dart';
import 'package:absensi/services/user_services.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class AuthServices {
  static auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  static Future<ResponseHandler> register(Auth authData) async {
    try {
      auth.UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: authData.email,
        password: authData.password,
      );

      UserModel user = result.user.convertToUser(
        name: authData.name,
        noTelp: authData.noTelp,
        nik: authData.nik,
        kategori: authData.kategori,
        jurusan: authData.jurusan,
        asalInstansi: authData.asalInstansi,
        alamatMagang: authData.alamatMagang,
        statusMagang: authData.statusMagang,
        mulaiMagang: authData.mulaiMagang,
        akhirMagang: authData.akhirMagang,
        // imei: authData.imei,
        // coordinate: authData.coordinate,
      );

      await UserServices.updateUser(user);

      return ResponseHandler(user: user);
    } 
    on auth.FirebaseAuthException catch (e) {
      return ResponseHandler(
        message: e.code,
      );
    } 
  }

  static Future<ResponseHandler> logIn(Auth authData) async {
    try {
      bool checkEmail = await UserServices.isEmailExists(authData.email);
      // bool matchImei = await UserServices.isImeiMatch(authData.email);

      if (!checkEmail) {
        return ResponseHandler(
          message: 'email-not-registered',
        );
      // } else if (!matchImei) {
      //   return ResponseHandler(
      //     message: 'imei-different',
      //   );
      }

      auth.UserCredential result = await _auth.signInWithEmailAndPassword(
        email: authData.email, 
        password: authData.password,
      );

      UserModel user = await result.user.fromFireStore();

      return ResponseHandler(user: user);
    }
    catch (e) {
      return ResponseHandler(
        message: 'wrong-password',
      );
    }
  }

  static Future<ResponseHandler> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);

      return ResponseHandler();
    } 
    catch (e) {
      return ResponseHandler(
        message: 'user-not-found',
      );
    }
  }

  static Future<void> logOut() async {
    await _auth.signOut();
  }

  static Stream<auth.User> get userStream => _auth.authStateChanges();
}
