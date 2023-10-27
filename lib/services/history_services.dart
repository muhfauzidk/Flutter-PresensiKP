// @dart=2.9

import 'package:absensi/Model/history.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryServices {
  static CollectionReference _historyCollection = FirebaseFirestore.instance.collection('histories');

  static Future<List<History>> getHistory(String userID) async {
    QuerySnapshot snapshot = await _historyCollection.get();

    var documents = snapshot.docs.where((document) => (document.data() as Map)['userID'] == userID);

    List<History> histories = [];

    for (var document in documents) {
      histories.add(
        History(
          userID: (document.data() as Map)['userID'],
          userName: (document.data() as Map)['userName'],
          userPhoto: (document.data() as Map)['userPhoto'],
          absentCheckIn: (document.data() as Map)['absentCheckIn'],
          absentCheckOut: (document.data() as Map)['absentCheckOut'],
        ),
      );
    }

    return histories;
  }

  static Future<void> storeHistory(History history) async {
    await _historyCollection.doc(history.absentCheckIn.toString()).set({
      'userID': history.userID,
      'userName': history.userName,
      'userPhoto': history.userPhoto,
      'absentCheckIn': history.absentCheckIn,
      'absentCheckOut': history.absentCheckOut,
    });
  }

  static Future<void> updateHistory(History history) async {
    await _historyCollection.doc(history.absentCheckIn.toString()).set({
      'userID': history.userID,
      'userName': history.userName,
      'userPhoto': history.userPhoto,
      'absentCheckIn': history.absentCheckIn,
      'absentCheckOut': history.absentCheckOut,
    });
  }
}