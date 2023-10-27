import 'package:absensi/Admin/Controllers/admin_users_data_controller.dart';
import 'package:absensi/Admin/Model/users_model.dart';
import 'package:absensi/common/common.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class UsersDataScreen extends GetView<UsersDataController> {
  static String routeName = "/users_data";

  Stream<List<User>> readUsers() => FirebaseFirestore.instance
      .collection('users')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());

  Widget buildUser(User user) => InkWell(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              width: 1,
              color: primaryExtraSoft,
            ),
          ),
          padding: EdgeInsets.only(left: 24, top: 20, right: 29, bottom: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Nama Lengkap",
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        (user.name == 'null') ? "-" : user.name,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "Email",
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        (user.email == 'null') ? "-" : user.email,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "Kategori",
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        (user.kategori == 'null') ? "-" : user.kategori,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "Jurusan",
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        (user.jurusan == 'null') ? "-" : user.jurusan,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "Asal Instansi",
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        (user.asalInstansi == 'null') ? "-" : user.asalInstansi,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "No Telp",
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        (user.noTelp == 'null') ? "-" : user.noTelp,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "NIK",
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        (user.nik == 'null') ? "-" : user.nik,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "Alamat Magang",
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        (user.alamatMagang == 'null') ? "-" : user.alamatMagang,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "Status Magang",
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        (user.statusMagang == 'null') ? "-" : user.statusMagang,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "Mulai Magang",
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        (user.mulaiMagang == 'null') ? "-" : user.mulaiMagang,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "Akhir Magang",
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        (user.akhirMagang == 'null') ? "-" : user.akhirMagang,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 6),
                    ],
                  ),
                  SizedBox(width: 24),
                ],
              ),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Data pengguna',
          style: TextStyle(
            color: secondary,
            fontSize: 14,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.green),
          onPressed: () {
            Get.back();
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: StreamBuilder<List<User>>(
          stream: readUsers(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong! ${snapshot.error}');
            } else if (snapshot.hasData) {
              final users = snapshot.data!;

              return ListView(
                children: users.map(buildUser).toList(),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
