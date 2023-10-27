import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class UsersDataController extends GetxController {
  late DocumentSnapshot snapshot;

  // Stream<List<User>> readUsers() => FirebaseFirestore.instance
  //   .collection('users')
  //   .snapshots()
  //   .map((snapshot) =>
  //       snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());
}
