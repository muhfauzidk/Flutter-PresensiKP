import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController emailC = TextEditingController();
  

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> sendEmail() async {
    if (emailC.text.isNotEmpty) {
      isLoading.value = true;
      print("called");
      try {
        print("success");
        auth.sendPasswordResetEmail(email: emailC.text);
        Get.back();
        emailC.clear();
        Fluttertoast.showToast(msg: "Link untuk reset password dikirim melalui email");
      } catch (e) {
        Fluttertoast.showToast(msg: "Cant send password reset link to your email. Error because : ${e.toString()}");
      } finally {
        isLoading.value = false;
      }
    } else {
      Fluttertoast.showToast(msg: "Email must be filled");
    }
  }
}
