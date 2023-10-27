// @dart=2.9

import 'dart:io';

class Auth {
  String email;
  String password;
  String name;
  String noTelp;
  String nik;
  String kategori;
  String jurusan;
  String asalInstansi;
  String alamatMagang;
  String statusMagang;
  String mulaiMagang;
  String akhirMagang;
  File photo;
  // List<String> imei;
  // List<String> coordinate;

  Auth({
    this.name = "No Name",
    this.email = "",
    this.password = "",
    this.noTelp = "",
    this.nik = "",
    this.kategori= "",
    this.jurusan = "",
    this.asalInstansi = "",
    this.alamatMagang = "",
    this.statusMagang = "",
    this.mulaiMagang = "",
    this.akhirMagang = "",
    this.photo,
    // this.imei = const [],
    // this.coordinate = const [],
  });
}