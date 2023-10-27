import 'package:absensi/Controller/page_index_controller.dart';
import 'package:absensi/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:absensi/widgets/custom_alert_dialog1.dart';

class LoginController extends GetxController {
  // final pageIndexController = Get.find<PageIndexController>();
  final pageIndexController =
      Get.put<PageIndexController>(PageIndexController());
  RxBool isLoading = false.obs;
  RxBool obsecureText = true.obs;
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  checkAdminRole() async {
    String uid = auth.currentUser!.uid;

    var collection = FirebaseFirestore.instance.collection('users');
    var docSnapshot = await collection.doc(uid).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      var value = data?['role']; // <-- The value you want to retrieve.
      // Call setState if needed.
      if (value == "Admin") {
        Get.offAllNamed(Routes.ADMIN);
        // pageIndexController.changePage(3);
      } else {
        Get.offAllNamed(Routes.MAIN);
        // pageIndexController.changePage(0);
      }
    }
  }

  checkUserRole() async {
    String uid = auth.currentUser!.uid;

    var collection = FirebaseFirestore.instance.collection('users');
    var collectionAdmin = FirebaseFirestore.instance.collection('admin');
    var docSnapshot = await collection.doc(uid).get();
    var docSnapshotAdmin = await collectionAdmin.doc(uid).get();
    if (docSnapshot.exists) {
      if (docSnapshotAdmin.exists) {
        Get.offAllNamed(Routes.ADMIN);
      } else {
        Get.offAllNamed(Routes.MAIN);
      }
    }
  }

  Future<void> login() async {
    if (emailC.text.isNotEmpty && passC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        final credential = await auth.signInWithEmailAndPassword(
          email: emailC.text.trim(),
          password: passC.text,
        );

        if (credential.user != null) {
          if (credential.user!.emailVerified) {
            isLoading.value = false;
            checkAdminRole();
            emailC.clear();
            passC.clear();
          } else {
            CustomAlertDialog.showPresenceAlert(
              title: "Email belum diverifikasi",
              message: "Kirim email verifikasi?",
              onCancel: () => Get.back(),
              onConfirm: () async {
                try {
                  await credential.user!.sendEmailVerification();
                  Get.back();
                  Fluttertoast.showToast(
                      msg: "Cek email anda untuk verifikasi");
                  isLoading.value = false;
                } catch (e) {
                  Fluttertoast.showToast(
                      msg:
                          "Tidak dapat mengirim email verifikasi. Error : ${e.toString()}");
                }
              },
            );
          }
        }
        isLoading.value = false;
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;
        if (e.code == 'user-not-found') {
          Fluttertoast.showToast(msg: "Akun tidak ditemukan");
        } else if (e.code == 'wrong-password') {
          Fluttertoast.showToast(msg: "Password Salah");
        }
      } catch (e) {
        Fluttertoast.showToast(msg: "Error : ${e.toString()}");
      }
    } else {
      Fluttertoast.showToast(
          msg: "Mohon isi email dan password terlebih dahulu");
    }
  }
}
