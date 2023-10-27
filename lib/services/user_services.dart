// @dart=2.9

import 'package:absensi/Model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class UserServices {
  static CollectionReference _userCollection = FirebaseFirestore.instance.collection('users');

  static Future<void> updateUser(UserModel user) async {
    await _userCollection.doc(user.uid).set({
      'email': user.email,
      'name': user.name,
      'noTelp': user.noTelp,
      'nik': user.nik,
      'kategori': user.kategori,
      'jurusan': user.jurusan,
      'asalInstansi': user.asalInstansi,
      'alamatMagang': user.alamatMagang,
      'statusMagang': user.statusMagang,
      'mulaiMagang': user.mulaiMagang,
      'akhirMagang': user.akhirMagang,
      // 'photoURL': user.photoURL,
      // 'imei': user.imei,
      // 'coordinate': user.coordinate,
    });
  }

  static Future<UserModel> getUser(String id) async {
    DocumentSnapshot snapshot = await _userCollection.doc(id).get();

    return UserModel(
      uid: id,
      email: (snapshot.data() as Map)['email'],
      name: (snapshot.data() as Map)['name'],
      noTelp: (snapshot.data() as Map)['noTelp'],
      nik: (snapshot.data() as Map)['nik'],
      kategori: (snapshot.data() as Map)['kategori'],
      jurusan: (snapshot.data() as Map)['jurusan'],
      asalInstansi: (snapshot.data() as Map)['asalInstansi'],
      alamatMagang: (snapshot.data() as Map)['alamatMagang'],
      statusMagang: (snapshot.data() as Map)['statusMagang'],
      mulaiMagang: (snapshot.data() as Map)['mulaiMagang'],
      akhirMagang: (snapshot.data() as Map)['akhirMagang'],
      // photoURL: (snapshot.data() as Map)['photoURL'],
      // imei: ((snapshot.data() as Map)['imei'] as List).map((e) => e.toString()).toList(),
      // coordinate: ((snapshot.data() as Map)['coordinate'] as List).map((e) => e.toString()).toList(),
    );
  }

  static Future<bool> isEmailExists(String email) async {
    QuerySnapshot snapshot = await _userCollection.where('email', isEqualTo: email).limit(1).get();
    List<DocumentSnapshot> documents = snapshot.docs;

    return documents.length == 1;
  }

  // static Future<bool> isImeiMatch(String email) async {
  //   List<String> getImeiMulti = await ImeiPlugin.getImeiMulti();

  //   QuerySnapshot snapshot = await _userCollection.where('imei', arrayContainsAny: getImeiMulti).limit(1).get();
  //   List<DocumentSnapshot> documents = snapshot.docs;

  //   return documents.length == 1;
  // }
}