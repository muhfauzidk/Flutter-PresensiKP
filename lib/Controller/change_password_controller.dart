import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController currentPassC = TextEditingController();
  TextEditingController newPassC = TextEditingController();
  TextEditingController confirmNewPassC = TextEditingController();

  RxBool oldPassObs = true.obs;
  RxBool newPassObs = true.obs;
  RxBool newPassCObs = true.obs;

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> updatePassword() async {
    if (currentPassC.text.isNotEmpty &&
        newPassC.text.isNotEmpty &&
        confirmNewPassC.text.isNotEmpty) {
      if (newPassC.text == confirmNewPassC.text) {
        isLoading.value = true;
        try {
          String emailUser = auth.currentUser!.email!;
          // checking if the current password is true
          await auth.signInWithEmailAndPassword(
              email: emailUser, password: currentPassC.text);
          // update password
          await auth.currentUser!.updatePassword(newPassC.text);

          currentPassC.clear();
          newPassC.clear();
          confirmNewPassC.clear();

          Get.back();
          Fluttertoast.showToast(msg: 'password berhasil diubah');
        } on FirebaseAuthException catch (e) {
          if (e.code == 'wrong-password') {
            Fluttertoast.showToast(msg: 'password lama salah');
          } else {
            Fluttertoast.showToast(
                msg: 'cant update password because : ${e.code}');
          }
        } catch (e) {
          Fluttertoast.showToast(msg: 'error : ${e.toString()}');
        } finally {
          isLoading.value = false;
        }
      } else {
        Fluttertoast.showToast(msg: 'konfirmasi password tidak sama');
      }
    } else {
      Fluttertoast.showToast(msg: 'Form masih kosong');
    }
  }
}
