// @dart=2.9

import 'package:absensi/Model/absent.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class AbsentServices {
  static CollectionReference _absentCollection = FirebaseFirestore.instance.collection('absents');
  static DatabaseReference absentDatabase = FirebaseDatabase.instance.reference().child('absents');

  static Future<void> storeAbsentCollection(Absent absent) async {
    await _absentCollection.doc().set({
      'userID': absent.userID,
      'userName': absent.userName,
      'userPhoto' : absent.userPhoto,
      'absentTime': absent.absentTime,
      'absentType': absent.absentType,
    });
  }

  static Future<void> storeAbsentDatabase(Absent absent) async {
    await absentDatabase.child(absent.userID).set({
      'userID': absent.userID,
      'userName': absent.userName,
      'userPhoto' : absent.userPhoto,
      'absentTime': absent.absentTime.millisecondsSinceEpoch,
      'absentType': absent.absentType,
    });
  }

  static Future<void> removeAbsentDatabase(String userID) async {
    await absentDatabase.child(userID).remove();
  }
}