// @dart=2.9

import 'package:absensi/Controller/change_password_controller.dart';
import 'package:absensi/Model/user_model.dart';
import 'package:absensi/common/common.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountSettingScreen extends StatelessWidget {
  static String routeName = "/account_setting_screen";
  final controller =
      Get.put<ChangePasswordController>(ChangePasswordController());

  final _auth = FirebaseAuth.instance;
  var selectedDate = DateTime.now();
  User user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  // string for displaying the error Message
  String errorMessage;

  // our form key
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //old password field
    final oldPasswordField = TextFormField(
        autofocus: false,
        obscureText: true,
        controller: controller.currentPassC,
        validator: (value) {
          if (value.isEmpty) {
            return ("Masukkan Password Lama");
          }
          return null;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          label: Text(
            "Password Lama",
            style: TextStyle(
              color: secondarySoft,
              fontSize: 14,
            ),
          ),
          prefixIcon: Icon(Icons.lock),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password Lama",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //new password field
    final passwordField = TextFormField(
        autofocus: false,
        obscureText: true,
        controller: controller.newPassC,
        validator: (value) {
          RegExp regex = RegExp(r'^.{6,}$');
          if (value.isEmpty) {
            return ("Masukkan Password Baru");
          }
          return null;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password Baru",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //confirm new password field
    final confirmPasswordField = TextFormField(
        autofocus: false,
        obscureText: true,
        controller: controller.confirmNewPassC,
        validator: (value) {
          RegExp regex = RegExp(r'^.{6,}$');
          if (value.isEmpty) {
            return ("Masukkan Konfirmasi Password Baru");
          }
          return null;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Konfirmasi Password Baru",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //signup button
    final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.green,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            controller.updatePassword();
          },
          child: Text(
            "Ganti Password",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.green),
          onPressed: () {
            // passing this to our root
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Ganti Password Akun",
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 44),
                  oldPasswordField,
                  SizedBox(height: 20),
                  passwordField,
                  SizedBox(height: 20),
                  confirmPasswordField,
                  SizedBox(height: 20),
                  signUpButton,
                  SizedBox(height: 15),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
