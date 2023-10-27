// @dart=2.9

import 'package:absensi/Model/user_model.dart';
import 'package:absensi/services/user_services.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

extension FirebaseUserExtension on auth.User {
  UserModel convertToUser({
    String name = "No Name",
    String noTelp = "",
    String nik = "",
    String kategori = "",
    String jurusan = "",
    String asalInstansi = "",
    String alamatMagang = "",
    String statusMagang = "",
    String mulaiMagang = "",
    String akhirMagang = "",
    // List<String> imei = const [],
    // List<String> coordinate = const [],
  }) {
    return UserModel(
      uid: this.uid,
      email: this.email,
      name: name,
      noTelp: noTelp,
      nik: nik,
      kategori: kategori,
      jurusan: jurusan,
      asalInstansi: asalInstansi,
      alamatMagang: alamatMagang,
      statusMagang: statusMagang,
      mulaiMagang: mulaiMagang,
      akhirMagang: akhirMagang,
      // imei: imei,
      // coordinate: coordinate, photoURL: '',
    );
  }

  Future<UserModel> fromFireStore() async => await UserServices.getUser(this.uid);
}
